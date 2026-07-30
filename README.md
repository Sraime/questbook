# Questbook

Questbook est une application Flutter de compagnon de jeu de rôle sur table : création et suivi de personnages, gestion des jets de dés, et organisation de tables de jeu. Le premier système supporté (« seedé ») est **L'Appel de Cthulhu, 7e édition**, mais l'architecture est pensée pour accueillir d'autres systèmes sans réécrire l'app.

## Sommaire

- [Aperçu fonctionnel](#aperçu-fonctionnel)
- [Stack technique](#stack-technique)
- [Architecture](#architecture)
  - [Arborescence](#arborescence)
  - [Couches applicatives](#couches-applicatives)
  - [Modèle de données](#modèle-de-données)
  - [Extensibilité multi-système](#extensibilité-multi-système)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Génération de code](#génération-de-code)
- [Exécution](#exécution)
- [Tests](#tests)
- [Limitations connues](#limitations-connues)

## Aperçu fonctionnel

- **Accueil (`/perso`)** : liste des personnages créés, avec un badge de points de vie et un accès rapide à la fiche.
- **Création de personnage (`/perso/create`)** : nom/occupation/description, tirage des caractéristiques (3d6 × 5, façon CdC v7) individuellement ou en une fois, répartition des points de compétence.
- **Fiche de personnage (`/perso/:id`)** : caractéristiques, compétences, ressources (PV/SAN/PM), inventaire, jets de compétence (1d100) et édition rapide des ressources.
- **Tables (`/tables`)** : liste des campagnes/tables de jeu, création d'une nouvelle table (titre + univers).

Toute l'interface utilise un design system interne « juicy » (boutons/cartes/dés avec relief, ombres et dégradés) inspiré d'une maquette produit, situé dans `lib/design_system/`.

## Stack technique

| Domaine | Choix |
| --- | --- |
| Framework | Flutter (SDK Dart `^3.12.2`, canal stable) |
| État / DI | [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) (`Notifier`, `Provider`, `FutureProvider`) |
| Navigation | [`go_router`](https://pub.dev/packages/go_router) (`StatefulShellRoute` pour la barre de navigation basse) |
| Persistance locale | [`drift`](https://pub.dev/packages/drift) + [`drift_flutter`](https://pub.dev/packages/drift_flutter) (SQLite embarqué) |
| Modèles immuables | [`freezed`](https://pub.dev/packages/freezed) / `freezed_annotation` |
| Sérialisation | `json_annotation` / `json_serializable` |
| UI | Design system maison (`qb_*` widgets), `google_fonts`, `lucide_icons_flutter` |
| Génération de code | `build_runner` (`drift_dev`, `freezed`, `json_serializable`) |

## Architecture

Le projet suit une architecture en couches façon *clean architecture* simplifiée : `domain` ne dépend de rien d'autre dans `lib/`, `data` implémente les interfaces de `domain`, et `features`/`design_system` consomment le tout via Riverpod.

### Arborescence

```
lib/
├── app/                       # Bootstrap : router, thème, providers racine
│   ├── router.dart            # Déclaration des routes go_router
│   ├── providers.dart         # DB, repositories, moteur de règles (DI)
│   └── theme.dart             # ThemeData Material basé sur les tokens du design system
├── domain/                    # Cœur métier, indépendant de Flutter/Drift
│   ├── models/                # Character, CharacterStat, CharacterResource,
│   │                          # GameSystem, GameTable, InventoryItem, Tone (freezed)
│   ├── repositories/          # Interfaces abstraites (Character/GameSystem/Table)
│   └── rules/                 # RulesEngine (interface) + CthulhuRulesEngine (implémentation v7)
├── data/
│   └── local/
│       ├── database.dart      # Schéma Drift (tables SQLite) + AppDatabase
│       ├── local_*_repository.dart  # Implémentations locales des repositories
│       └── seed/               # Données de départ (catalogue Cthulhu) + seedDatabase()
├── design_system/
│   ├── tokens/                # colors, spacing, typography, effects (constantes de design)
│   └── components/            # Widgets réutilisables préfixés qb_ (bouton, carte, dés, etc.)
├── features/                   # Un dossier par écran/flux, avec ses providers Riverpod locaux
│   ├── home/                   # Écran « Mes personnages »
│   ├── character_creation/     # Création de personnage + modale de jet de caractéristique
│   ├── character_sheet/        # Fiche de personnage + modales (jet de compétence, ressource)
│   ├── tables/                  # Écran « Mes tables »
│   └── shell/                   # AppShell : bottom nav bar persistante (StatefulShellRoute)
├── services/
│   └── dice_service.dart       # Primitives de lancer de dés (dNombre, dPourcent), testable isolément
└── main.dart                    # Point d'entrée : ProviderScope + MaterialApp.router
```

### Couches applicatives

1. **`domain`** définit *quoi* (modèles + contrats de repository) et *comment calculer* (interface `RulesEngine`), sans savoir comment c'est stocké ni affiché.
2. **`data/local`** persiste ces modèles dans SQLite via Drift (`AppDatabase`), et traduit entre les lignes Drift générées (`*Row`) et les modèles `domain` dans les `Local*Repository`.
3. **`app/providers.dart`** est le point de câblage (DI) : il expose `appDatabaseProvider`, un provider par repository, et `rulesEngineProvider`. C'est le seul endroit à modifier pour brancher un futur backend distant (`Remote*Repository`) à la place du local.
4. **`features/*`** contient un `Notifier`/`AsyncNotifier` Riverpod par écran (ex. `CharacterCreationNotifier`, `CharacterListProvider`) qui lit les repositories/le rules engine, et les widgets d'écran qui les consomment via `ConsumerWidget`/`ConsumerStatefulWidget`.
5. **`design_system`** ne connaît ni Riverpod ni le domaine métier : ce sont des widgets purs paramétrés par variant/label/callback, réutilisés à l'identique entre les écrans.

### Modèle de données

Schéma Drift (`lib/data/local/database.dart`), modélisant un système de jeu générique :

- `GameSystems` — un système de jeu (ex. `cthulhu-v7`) avec ses suggestions d'occupation.
- `Characters` — rattaché à un `GameSystem`, avec nom/occupation/description/niveau.
- `CharacterStats` — caractéristiques **et** compétences d'un personnage (`kind` distingue les deux), génériques sur `key`/`label`/`value` pour rester agnostiques du système.
- `CharacterResources` — ressources consommables (PV, SAN, PM…) avec valeur courante/max et un `tone` d'affichage.
- `InventoryItems` — objets possédés par un personnage.
- `GameTables` — tables/campagnes, éventuellement rattachées à un système.

Ce schéma générique (`kind`/`key`/`label`/`value`) permet d'ajouter un nouveau système de jeu sans migration : seul le catalogue (`CthulhuSeed`-like) et l'implémentation `RulesEngine` changent.

### Extensibilité multi-système

`RulesEngine` (`lib/domain/rules/rules_engine.dart`) isole toute la mécanique spécifique à un système :

```dart
abstract interface class RulesEngine {
  String get systemId;
  CharacteristicRoll rollCharacteristic({int bonus = 0, Random? random});
  Map<String, int> computeDerivedCharacteristics(Map<String, int> primary);
  SkillCheckResult rollSkillCheck(int targetValue, {Random? random});
}
```

`CthulhuRulesEngine` en est la seule implémentation aujourd'hui (jets 3d6×5, dérivées ESQ/MVT/COR/IMP, jets de compétence 1d100 avec critiques 01-05/96-100). Ajouter un système (D&D 5e, Vampire…) consiste à :
1. écrire un nouveau catalogue de caractéristiques/compétences (à la manière de `CthulhuSeed`) ;
2. écrire une nouvelle implémentation de `RulesEngine` ;
3. faire de `rulesEngineProvider` une map `systemId -> RulesEngine` plutôt qu'une instance unique.

## Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (canal stable — projet testé avec Flutter 3.44.x / Dart 3.12.x).
- Un IDE avec plugin Flutter/Dart (VS Code, Android Studio…) ou juste la CLI.
- Pour lancer sur mobile :
  - **Android** : Android SDK + un émulateur configuré, ou un appareil physique en mode debug USB.
  - **iOS** (macOS uniquement) : Xcode + CocoaPods, ou un simulateur iOS.
- Vérifier l'environnement :
  ```bash
  flutter doctor
  ```

> ℹ️ Seuls les dossiers `android/` et `ios/` sont présents dans ce dépôt : il n'y a pas de support desktop (`windows/`) ni web (`web/`) configuré nativement. Voir [Limitations connues](#limitations-connues).

## Installation

```bash
git clone <url-du-dépôt>
cd questbook
flutter pub get
```

## Génération de code

Le projet utilise `build_runner` pour générer :
- les classes Drift (`*.g.dart`) à partir du schéma dans `database.dart` ;
- les classes `freezed`/`json_serializable` (`*.freezed.dart`, `*.g.dart`) pour les modèles du dossier `domain/models/`.

Les fichiers générés sont déjà commités, mais après toute modification d'un modèle `@freezed` ou du schéma Drift, régénérez-les avec :

```bash
dart run build_runner build --delete-conflicting-outputs
```

(ou `dart run build_runner watch --delete-conflicting-outputs` pendant le développement actif des modèles).

## Exécution

1. Lister les appareils/émulateurs disponibles :
   ```bash
   flutter devices
   flutter emulators
   ```
2. Démarrer un émulateur Android si besoin (remplacez l'id par celui listé ci-dessus, par ex. `questbook_test`) :
   ```bash
   flutter emulators --launch <id_emulateur>
   ```
3. Lancer l'application :
   ```bash
   flutter run -d <id_appareil>
   # ex. flutter run -d emulator-5554
   ```

Au premier lancement, `databaseInitProvider` (voir `lib/app/providers.dart`) crée la base SQLite locale et insère le système « Appel de Cthulhu v7 » (`seedDatabase`) — aucun personnage ni table de démo n'est pré-créé.

### Recharge à chaud

Une fois `flutter run` actif dans un terminal interactif, les commandes clavier standard fonctionnent :
- `r` → hot reload
- `R` → hot restart
- `q` → quitter

### Web / Desktop

Ce dépôt ne contient pas les dossiers `web/` ni `windows/`/`linux/`/`macos/`. `flutter run -d chrome` peut fonctionner en apparence, mais **la persistance Drift (SQLite via IndexedDB/OPFS) nécessite des fichiers `sqlite3.wasm` + un worker JS** qui ne sont générés qu'après `flutter create .` (ce qui ajoute les dossiers de plateforme manquants). Sans cette étape, l'appli peut rester bloquée sur l'écran de chargement/erreur. Si vous avez besoin d'une cible web ou desktop :
```bash
flutter create .
flutter run -d chrome     # ou -d windows / -d linux / -d macos
```

## Tests

```bash
flutter test
```

Tests actuellement présents (`test/`) :
- `domain/rules/cthulhu_rules_engine_test.dart` — mécaniques de jet (caractéristiques, dérivées, jets de compétence).
- `services/dice_service_test.dart` — primitives de lancer de dés.

## Limitations connues

- Un seul système de jeu est seedé (`cthulhu-v7`) : le catalogue de compétences/caractéristiques est actuellement importé statiquement (`CthulhuSeed`) plutôt que résolu dynamiquement par `systemId`.
- Pas de support desktop/web packagé nativement (voir ci-dessus).
- Aucune synchronisation distante : tout est stocké en local via SQLite (Drift). Le remplacement par un backend distant se ferait en ajoutant des implémentations `Remote*Repository` et en modifiant uniquement `lib/app/providers.dart`.
- L'écran « Tables » ne propose pas encore d'écran de détail : ouvrir une table existante est un no-op pour l'instant.
