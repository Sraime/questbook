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
- [Workflow git (branches)](#workflow-git-branches)
- [Distribution Android (signature, Firebase, CI/CD)](#distribution-android-signature-firebase-cicd)
  - [Vue d'ensemble](#vue-densemble)
  - [Signature de release](#signature-de-release)
  - [Firebase App Distribution](#firebase-app-distribution)
  - [CI GitHub Actions](#ci-github-actions)
  - [Déployer manuellement (sans la CI)](#déployer-manuellement-sans-la-ci)
  - [Reprendre ce setup sur une nouvelle machine](#reprendre-ce-setup-sur-une-nouvelle-machine)
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

## Workflow git (branches)

Le dépôt suit un git-flow simplifié à deux branches :

- **`dev`** — branche de travail. Toutes les modifications (features, fixes,
  docs…) sont commitées ici (directement ou via des branches
  `feature/xxx` ouvertes depuis `dev`, selon la taille du changement).
  Pousser sur `dev` **ne déclenche aucun build/déploiement**.
- **`main`** — branche de release, protégée. Elle ne doit être mise à jour
  que via une **Pull Request `dev` → `main`**, jamais par un push direct.
  C'est le *merge* de cette PR qui déclenche automatiquement la CI (build +
  distribution Firebase App Distribution — voir section suivante).

En pratique :

```bash
git checkout dev
# ... commits de travail ...
git push origin dev
# Puis, une fois prêt à livrer une version aux testeurs :
# ouvrir une Pull Request "dev → main" sur GitHub et la merger.
```

> ℹ️ Pour que `main` reste vraiment protégée, active sur GitHub
> `Settings → Branches → Branch protection rules` une règle sur `main`
> exigeant une Pull Request avant tout merge (« Require a pull request
> before merging »). Sans ça, rien n'empêche techniquement un push direct
> sur `main`, qui ne déclencherait d'ailleurs pas la CI non plus (le
> workflow n'écoute que l'événement « Pull Request fermée en tant que
> merged », pas les push) — mais court-circuiterait la revue de code.

## Distribution Android (signature, Firebase, CI/CD)

### Vue d'ensemble

Le projet est connecté à un projet Firebase (**`questbook-48540`**) uniquement
pour distribuer des builds de test aux beta-testeurs via **Firebase App
Distribution** — il n'y a aujourd'hui aucun SDK Firebase (Auth, Analytics,
Firestore…) intégré dans l'app elle-même, uniquement de l'outillage de
distribution. Le flux complet, une fois poussé sur `main` :

```
Pull Request "dev → main" mergée sur GitHub
   └─▶ GitHub Actions (.github/workflows/firebase-distribution.yml)
          ├─ flutter build apk --release   (signé avec la clé "upload")
          └─ firebase appdistribution:distribute
                 └─▶ groupe de testeurs "testeurs" sur Firebase App Distribution
                        └─▶ email + lien de téléchargement pour chaque testeur
```

Trois briques composent ce dispositif, détaillées ci-dessous : la **signature
release**, le **projet Firebase**, et le **workflow CI**.

### Signature de release

Par défaut, un projet Flutter fraîchement créé signe ses builds `release`
avec la clé de debug (`android/app/build.gradle.kts` originel) — ce qui
fonctionne mais n'est pas une vraie release signée. Ce repo utilise une
vraie clé de signature dédiée (« clé upload »), stockée **hors du dépôt
git** :

- La clé elle-même (`upload-keystore.jks`, RSA 2048, alias `upload`) et ses
  mots de passe ne sont **jamais commités** — ils vivent uniquement dans un
  dossier local `.secrets/` (gitignoré) et dans les secrets GitHub Actions
  (voir plus bas).
- `android/app/build.gradle.kts` lit un fichier `android/key.properties`
  (également gitignoré) au moment du build :

  ```properties
  storePassword=...
  keyPassword=...
  keyAlias=upload
  storeFile=/chemin/vers/upload-keystore.jks
  ```

  Si `android/key.properties` n'existe pas (ex. sur un checkout tout frais
  sans accès au keystore), le build `release` **retombe automatiquement sur
  la signature debug** — `flutter run --release` continue donc de fonctionner
  sans configuration supplémentaire, seule la distribution vers de vrais
  testeurs nécessite la vraie clé.
- Pourquoi un seul mot de passe (`storePassword` == `keyPassword`) ? Les
  keystores `PKCS12` (format par défaut des JDK récents) ne supportent pas
  des mots de passe distincts pour le keystore et l'alias — `keytool` ignore
  silencieusement `-keypass` si différent de `-storepass`.

> ⚠️ **Ne perds pas ce keystore.** Pour l'instant l'app n'est distribuée que
> via Firebase App Distribution donc ce n'est pas critique, mais le jour où
> l'app est publiée sur le Play Store *sans* Play App Signing, perdre cette
> clé signifie ne plus jamais pouvoir publier de mise à jour sous le même
> `applicationId`. Sauvegarde `.secrets/upload-keystore.jks` dans un
> gestionnaire de mots de passe/coffre-fort d'équipe.

### Firebase App Distribution

- **Projet Firebase** : `questbook-48540` (console :
  [console.firebase.google.com/project/questbook-48540](https://console.firebase.google.com/project/questbook-48540)).
- **App Android enregistrée** : package `com.questbook.questbook`, App ID
  Firebase `1:56734402863:android:8f12f08f8eff13a8e2b9da` (visible dans
  Project settings → General, ou via `firebase apps:list`).
- **Groupe de testeurs** : alias `testeurs` (affiché « Testeurs Questbook »
  dans la console). Ajouter un testeur :
  ```bash
  firebase appdistribution:testers:add nouveau.testeur@example.com --group-alias testeurs --project questbook-48540
  ```
- Chaque testeur reçoit un email d'invitation avec un lien de téléchargement
  direct (aucun compte Google Play/bêta-test public requis).

### CI GitHub Actions

Le workflow [`.github/workflows/firebase-distribution.yml`](.github/workflows/firebase-distribution.yml)
se déclenche :
- automatiquement quand une **Pull Request vers `main` est mergée**
  (événement `pull_request` de type `closed`, filtré par
  `github.event.pull_request.merged == true` pour ignorer les PR fermées
  sans être mergées) — voir [Workflow git](#workflow-git-branches) ;
- ou manuellement depuis l'onglet **Actions** du repo GitHub (bouton
  « Run workflow »), avec des notes de version personnalisées en option.

Volontairement, un simple `push` sur `main` (ou sur toute autre branche) ne
déclenche **rien** : ça évite de redéployer un build de test à chaque petit
commit (doc, refactor…) qui n'apporte aucune évolution fonctionnelle.

Il enchaîne : checkout → setup Flutter/JDK → `flutter pub get` → décodage du
keystore + écriture de `key.properties` à partir des secrets → 
`flutter build apk --release` → installation de `firebase-tools` →
`firebase appdistribution:distribute` vers le groupe `testeurs` → nettoyage
des fichiers de signature sur le runner.

Il a besoin de **5 secrets** définis dans
`Settings → Secrets and variables → Actions` du repo GitHub :

| Secret                      | Contenu                                                              |
| ---------------------------- | --------------------------------------------------------------------- |
| `ANDROID_KEYSTORE_BASE64`   | Le fichier `upload-keystore.jks` encodé en base64 (une seule ligne)   |
| `ANDROID_KEYSTORE_PASSWORD` | Mot de passe du keystore (`storePassword`)                            |
| `ANDROID_KEY_PASSWORD`      | Idem (même valeur, voir note PKCS12 ci-dessus)                        |
| `ANDROID_KEY_ALIAS`         | `upload`                                                               |
| `FIREBASE_TOKEN`            | Token CI généré via `firebase login:ci` (voir note de dépréciation ci-dessous) |

L'App ID Firebase et le Project ID ne sont *pas* secrets — ils sont en dur
dans le workflow (`env:` en tête de fichier).

> ⚠️ `firebase login:ci` / l'option `--token` de `firebase-tools` sont
> marquées comme dépréciées par Google au profit de l'authentification par
> compte de service. Elles fonctionnent encore avec `firebase-tools` 15.x
> (utilisé ici), mais si Google les retire dans une future version majeure,
> il faudra migrer l'étape « Distribute » du workflow vers un compte de
> service GCP (rôle *Firebase App Distribution Admin*) exposé via
> `GOOGLE_APPLICATION_CREDENTIALS`, en remplacement de `--token`.

### Déployer manuellement (sans la CI)

Utile en local si tu as le keystore et que tu veux tester une distribution
avant de pousser :

```bash
flutter build apk --release
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
  --app 1:56734402863:android:8f12f08f8eff13a8e2b9da \
  --project questbook-48540 \
  --groups "testeurs" \
  --release-notes "Description de ce build"
```

(nécessite `firebase login` préalable — sur Windows/PowerShell, utiliser
`firebase.cmd` si l'exécution de scripts `.ps1` est bloquée par la
politique d'exécution).

### Reprendre ce setup sur une nouvelle machine

Un `git clone` frais **n'inclut ni le keystore ni les mots de passe**
(volontairement, ils sont gitignorés). Deux cas :

- **Tu veux juste lancer/développer l'app** : rien à faire, les builds
  `debug` et même `release` fonctionnent (signature debug de repli — voir
  [Signature de release](#signature-de-release)).
- **Tu veux publier/distribuer un vrai build** : il te faut le fichier
  `upload-keystore.jks` existant (demande-le à un mainteneur ayant accès à
  `.secrets/`, ne le régénère surtout pas — un nouveau keystore ne
  correspondrait plus à ce qui a déjà été distribué) et recréer localement
  un `android/key.properties` qui pointe dessus, avec les mêmes valeurs que
  celles utilisées dans les secrets GitHub `ANDROID_KEYSTORE_*`.

## Limitations connues

- Un seul système de jeu est seedé (`cthulhu-v7`) : le catalogue de compétences/caractéristiques est actuellement importé statiquement (`CthulhuSeed`) plutôt que résolu dynamiquement par `systemId`.
- Pas de support desktop/web packagé nativement (voir ci-dessus).
- Aucune synchronisation distante : tout est stocké en local via SQLite (Drift). Le remplacement par un backend distant se ferait en ajoutant des implémentations `Remote*Repository` et en modifiant uniquement `lib/app/providers.dart`.
- L'écran « Tables » ne propose pas encore d'écran de détail : ouvrir une table existante est un no-op pour l'instant.
- Distribution actuelle limitée à Firebase App Distribution (bêta-testeurs) ; pas encore de publication Play Store, ni de Play App Signing (la clé de signature `upload` est gérée manuellement — voir [Distribution Android](#distribution-android-signature-firebase-cicd)).
- L'authentification CI Firebase (`firebase login:ci` / `--token`) repose sur un mécanisme déprécié par Google ; à migrer vers un compte de service GCP si `firebase-tools` le retire dans une future version majeure.
