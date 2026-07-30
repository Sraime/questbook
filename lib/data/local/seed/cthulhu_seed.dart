/// Seed data for the Cthulhu v7 GameSystem — ported verbatim from the
/// imported mockup's `skillsCatalog`/`occupationOptions`/characteristics.
/// Sentinel [CthulhuSkillDef.baseValue] of -1 means "derived from a
/// characteristic at creation time" (Esquive = DEX/2, Langue maternelle =
/// ÉDU) rather than a flat starting percentage.
class CthulhuSkillDef {
  const CthulhuSkillDef(this.key, this.label, this.baseDisplay, this.baseValue);

  final String key;
  final String label;
  final String baseDisplay;
  final int baseValue;
}

class CthulhuCharacteristicDef {
  const CthulhuCharacteristicDef(this.key, this.label);

  final String key;
  final String label;
}

abstract final class CthulhuSeed {
  static const systemId = 'cthulhu-v7';
  static const systemName = 'Appel de Cthulhu v7';

  static const occupationSuggestions = [
    'Bibliothécaire',
    'Détective privé',
    'Journaliste',
    'Antiquaire',
    "Professeur d'université",
    'Médecin',
  ];

  static const primaryCharacteristics = [
    CthulhuCharacteristicDef('FOR', 'Force'),
    CthulhuCharacteristicDef('DEX', 'Dextérité'),
    CthulhuCharacteristicDef('CON', 'Constitution'),
    CthulhuCharacteristicDef('POU', 'Pouvoir'),
    CthulhuCharacteristicDef('APP', 'Apparence'),
    CthulhuCharacteristicDef('EDU', 'Éducation'),
    CthulhuCharacteristicDef('INT', 'Intelligence'),
    CthulhuCharacteristicDef('TAI', 'Taille'),
  ];

  static const derivedCharacteristics = [
    CthulhuCharacteristicDef('MVT', 'Mouvement'),
    CthulhuCharacteristicDef('IMP', 'Bonus dégâts'),
    CthulhuCharacteristicDef('COR', 'Carrure'),
    CthulhuCharacteristicDef('ESQ', 'Esquive'),
  ];

  /// key, label, base %.
  static const skillCatalog = [
    CthulhuSkillDef('anthropologie', 'Anthropologie', '01 %', 1),
    CthulhuSkillDef('archeologie', 'Archéologie', '01 %', 1),
    CthulhuSkillDef('arts_et_metiers', 'Arts et métiers', '05 %', 5),
    CthulhuSkillDef('baratin', 'Baratin', '05 %', 5),
    CthulhuSkillDef('bibliotheque', 'Bibliothèque', '20 %', 20),
    CthulhuSkillDef('charme', 'Charme', '15 %', 15),
    CthulhuSkillDef('combat_distance_armes_poing',
        'Combat à distance (armes de poing)', '20 %', 20),
    CthulhuSkillDef(
        'combat_distance_fusils', 'Combat à distance (fusils)', '25 %', 25),
    CthulhuSkillDef('combat_rapproche',
        'Combat rapproché (corps à corps)', '25 %', 25),
    CthulhuSkillDef('comptabilite', 'Comptabilité', '05 %', 5),
    CthulhuSkillDef('conduite', 'Conduite', '20 %', 20),
    CthulhuSkillDef('conduite_engin_lourd', 'Conduite engin lourd', '01 %', 1),
    CthulhuSkillDef('credit', 'Crédit', '00 %', 0),
    CthulhuSkillDef('crochetage', 'Crochetage', '01 %', 1),
    CthulhuSkillDef('discretion', 'Discrétion', '20 %', 20),
    CthulhuSkillDef('droit', 'Droit', '05 %', 5),
    CthulhuSkillDef('ecouter', 'Écouter', '20 %', 20),
    CthulhuSkillDef('electricite', 'Électricité', '10 %', 10),
    CthulhuSkillDef('equitation', 'Équitation', '05 %', 5),
    CthulhuSkillDef('esquive', 'Esquive', 'DEX/2', -1),
    CthulhuSkillDef('estimation', 'Estimation', '05 %', 5),
    CthulhuSkillDef('grimper', 'Grimper', '20 %', 20),
    CthulhuSkillDef('histoire', 'Histoire', '05 %', 5),
    CthulhuSkillDef('imposture', 'Imposture', '05 %', 5),
    CthulhuSkillDef('intimidation', 'Intimidation', '15 %', 15),
    CthulhuSkillDef('lancer', 'Lancer', '20 %', 20),
    CthulhuSkillDef('langue_maternelle', 'Langue maternelle', 'ÉDU', -1),
    CthulhuSkillDef('langues', 'Langues', '01 %', 1),
    CthulhuSkillDef('mecanique', 'Mécanique', '10 %', 10),
    CthulhuSkillDef('medecine', 'Médecine', '01 %', 1),
    CthulhuSkillDef('mythe_de_cthulhu', 'Mythe de Cthulhu', '00 %', 0),
    CthulhuSkillDef('nager', 'Nager', '20 %', 20),
    CthulhuSkillDef('naturalisme', 'Naturalisme', '10 %', 10),
    CthulhuSkillDef('occultisme', 'Occultisme', '05 %', 5),
    CthulhuSkillDef('orientation', 'Orientation', '10 %', 10),
    CthulhuSkillDef('persuasion', 'Persuasion', '10 %', 10),
    CthulhuSkillDef('pickpocket', 'Pickpocket', '10 %', 10),
    CthulhuSkillDef('pilotage', 'Pilotage', '01 %', 1),
    CthulhuSkillDef('pister', 'Pister', '10 %', 10),
    CthulhuSkillDef('plongee', 'Plongée', '01 %', 1),
    CthulhuSkillDef('premiers_soins', 'Premiers soins', '30 %', 30),
    CthulhuSkillDef('psychanalyse', 'Psychanalyse', '01 %', 1),
    CthulhuSkillDef('psychologie', 'Psychologie', '10 %', 10),
    CthulhuSkillDef('sauter', 'Sauter', '20 %', 20),
    CthulhuSkillDef('sciences', 'Sciences', '01 %', 1),
    CthulhuSkillDef('survie', 'Survie', '10 %', 10),
    CthulhuSkillDef('trouver_objet_cache', 'Trouver Objet Caché', '25 %', 25),
  ];
}
