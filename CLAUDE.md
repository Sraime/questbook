# CLAUDE.md

Contexte projet pour les agents IA (Claude Code, Cursor, etc.). Pour la
documentation fonctionnelle/architecture complète, voir **`README.md`** —
ce fichier ne duplique pas ce qui y est déjà bien expliqué, il se concentre
sur ce qu'un agent doit savoir *avant d'agir* : pièges connus, conventions,
et état actuel du projet.

## En une phrase

Questbook = app Flutter de compagnon de jeu de rôle sur table (perso,
compétences, dés, tables de jeu), seedée avec L'Appel de Cthulhu v7.
Riverpod + go_router + Drift (SQLite local). UI et textes en **français**,
code/commentaires en **anglais**.

## Avant de coder : lire le README

`README.md` documente en détail : architecture en couches (`domain` →
`data` → `app/providers.dart` → `features`), schéma Drift, le pattern
`RulesEngine` pour l'extensibilité multi-système, et toute la chaîne de
signature/distribution/CI. Le lire d'abord évite de redécouvrir tout ça à
chaque session.

## Environnement de dev (Windows)

Ce projet est développé sur **Windows / PowerShell**. Pièges rencontrés :

- **PowerShell bloque les scripts `.ps1`** installés par npm (politique
  d'exécution par défaut). Pour `firebase-tools`, utiliser `firebase.cmd`
  au lieu de `firebase` (le `.cmd` contourne le blocage sans toucher à la
  politique système).
- **`git push`/`firebase login` sont interactifs** (ouvrent un navigateur
  via Git Credential Manager / OAuth) — ça ne fonctionne **pas** depuis un
  shell non-interactif automatisé. Il faut soit laisser l'utilisateur
  lancer la commande lui-même dans son propre terminal, soit utiliser une
  méthode non-interactive (token, `--with-token`, etc.).
- **`keytool` n'est pas dans le PATH** mais existe dans le JDK embarqué
  d'Android Studio : `C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe`.
- **Fichiers `.properties` Java** (ex. `android/key.properties`) : un
  backslash Windows dans une valeur (`storeFile=C:\Users\...`) casse le
  parsing (`Malformed \uxxxx encoding`). Toujours utiliser des slashs `/`
  dans ces fichiers.
- Un émulateur Android est déjà configuré : `questbook_test` (voir
  `flutter emulators`). Le web (`flutter run -d chrome`) et le desktop ne
  sont **pas** configurés nativement dans ce repo (pas de dossier `web/`
  ni `windows/`) — voir la section Web/Desktop du README avant d'essayer.

## Secrets — ne jamais committer, ne jamais afficher en clair

- `.secrets/` (keystore de release, mots de passe, tokens) et
  `android/key.properties` sont gitignorés. Ne pas les recréer à la légère
  ni en afficher le contenu dans une réponse — les lire/écrire via des
  commandes qui ne les impriment pas en sortie.
- Le keystore de release (`upload-keystore.jks`, alias `upload`) ne doit
  **jamais être régénéré** une fois des builds distribués avec — ça
  casserait la continuité des mises à jour. Voir README →
  [Signature de release](README.md#signature-de-release).

## Git flow — important pour toute future contribution

- **`dev`** = branche de travail (tout se commit ici, ou sur des branches
  `feature/*` ouvertes depuis `dev`).
- **`main`** = branche de release, protégée. Mise à jour **uniquement**
  via Pull Request `dev → main`, jamais de push direct.
- La CI (`.github/workflows/firebase-distribution.yml`) ne se déclenche
  **que** quand une PR vers `main` est mergée (ou manuellement via
  `workflow_dispatch`) — surtout pas à chaque push, pour ne pas spammer les
  testeurs Firebase avec des builds sans évolution fonctionnelle.
- Avant de proposer un `git push origin main` direct : s'arrêter et
  proposer une PR depuis `dev` à la place.

## Commandes utiles

```bash
flutter pub get                                              # dépendances
dart run build_runner build --delete-conflicting-outputs     # régénère Drift/freezed/json_serializable
flutter test                                                 # tests unitaires
flutter run -d <device_id>                                   # lancer (voir `flutter devices`)
flutter build apk --release                                  # build release (signé si android/key.properties existe, sinon fallback debug)
```

## Pièges Riverpod/Flutter déjà rencontrés dans ce code

- **Ne jamais muter un provider Riverpod de façon synchrone dans
  `initState()`** d'un widget affiché pendant un build (ex. une modale
  ouverte depuis `onTap`). Ça lève `Tried to modify a provider while the
  widget tree was building`. Solution appliquée : différer l'appel via
  `WidgetsBinding.instance.addPostFrameCallback`. Voir
  `lib/features/character_creation/widgets/characteristic_roll_dialog.dart`
  pour l'exemple corrigé.
- **`QBButton`** (`lib/design_system/components/qb_button.dart`) enveloppe
  son contenu dans un `FittedBox` pour éviter les `RenderFlex overflowed`
  quand un label français long est utilisé dans une rangée de boutons
  serrée (ex. deux `QBButton` côte à côte dans une modale de 320px). Si un
  nouveau label déborde encore, c'est probablement un cas plus extrême du
  même problème — pas la peine de rajouter un `FittedBox` ad hoc ailleurs,
  le composant le gère déjà.
- Les captures d'écran/diagnostics sur cette machine passent par **`adb`**
  directement (`$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe`) —
  utiliser `adb shell screencap -p /sdcard/x.png` + `adb pull`, jamais
  `adb exec-out ... > fichier` en PowerShell (corrompt le PNG binaire à
  cause de la traduction de fin de ligne).

## Firebase (App Distribution uniquement, pas de SDK dans l'app)

- Projet `questbook-48540`, app Android
  `1:56734402863:android:8f12f08f8eff13a8e2b9da`, groupe de testeurs
  `testeurs`. Détails complets dans README →
  [Distribution Android](README.md#distribution-android-signature-firebase-cicd).
