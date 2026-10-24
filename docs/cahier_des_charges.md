# AgroSim Lab --- Cahier des charges technique et roadmap

**Version :** 1.0\
**Date :** 24 octobre 2026\
**Domaine :** simulation, automatique, commande, vérification et
validation\
**Outils principaux :** MATLAB, Simulink, Git/GitHub\
**Statut :** spécification initiale --- les paramètres sont
illustratifs, pas des mesures de terrain.

## 0. Mode d'emploi

Ce document est la référence du projet. Toute modification importante
doit être justifiée et tracée. Le projet doit progresser par jalons
vérifiables, non par accumulation de fonctionnalités.

Principes : 1. Construire et vérifier le modèle avant l'interface
graphique. 2. Toute exigence doit avoir un critère d'acceptation et, si
possible, un test associé. 3. Conserver les résultats négatifs et
expliquer les échecs. 4. Distinguer simulation, vérification numérique
et validation par données de référence. 5. Ne jamais présenter des
paramètres de démonstration comme des mesures de Zè ou d'Adjohoun. 6.
Commencer les candidatures PFE en parallèle du projet : ne pas attendre
la fin du portfolio.

## 1. Résumé et objectif professionnel

AgroSim Lab est un laboratoire virtuel qui modélise l'évolution de
l'humidité d'une couche de sol sous l'effet des précipitations, de
l'évapotranspiration et du drainage, puis compare des stratégies de
gestion de l'eau. Le contexte est motivé par deux risques agricoles :
l'excès d'eau après des pluies ou inondations, et le déficit hydrique
pendant les périodes sèches.

La V1 est un modèle dynamique concentré et testable, pas un outil de
décision agricole opérationnel. Des données de terrain et une expertise
agronomique seraient nécessaires pour calibrer et valider le modèle dans
une exploitation réelle.

Le projet doit démontrer les compétences suivantes : - traduire un
problème en exigences vérifiables ; - écrire et documenter un modèle
dynamique ; - implémenter et diagnostiquer un modèle dans Simulink ; -
concevoir une commande et comparer des stratégies ; - planifier des
tests, vérifier des résultats et tracer les anomalies ; - analyser des
données et générer des rapports reproductibles ; - présenter les
hypothèses, les limites et les preuves comme en ingénierie
professionnelle.

Métiers ciblés : Simulation Engineer, Model-Based Design Engineer, Test
& Validation Engineer, Systems Validation Engineer, Control Systems
Engineer et ingénierie d'intégration. Le projet peut aussi montrer des
compétences transférables à la digitalisation industrielle.

## 2. Périmètre

### V1 --- obligatoire

-   modèle à un état : humidité volumique du sol ;
-   bilan hydrique avec pluie infiltrée, irrigation, évapotranspiration
    et drainage ;
-   limites physiques et diagnostic du bilan de masse ;
-   profils d'entrée paramétrables ;
-   scénario pluie puis période sèche ;
-   commande à seuils avec hystérésis ;
-   au moins dix scénarios de test ;
-   indicateurs, figures et rapport de validation.

### V2 --- après validation de la V1

-   infiltration limitée et ruissellement de surface ;
-   apport d'eau distinct représentant un scénario d'inondation ;
-   analyse de sensibilité et tests de robustesse ;
-   comparaison avec une commande améliorée ou une commande prédictive
    simplifiée ;
-   génération automatisée du rapport.

### V3 --- facultatif

-   modèle multicouche ;
-   modèle de mesure bruitée ou estimation d'état ;
-   données météo réelles avec sources citées ;
-   comparaison à des mesures de terrain si elles sont accessibles ;
-   interface de visualisation ou prototype physique uniquement si cela
    apporte une valeur claire.

### Hors périmètre initial

-   déploiement opérationnel sur une exploitation ;
-   prédiction météorologique ;
-   dimensionnement agronomique complet ;
-   réseau IoT et application mobile avant la vérification du modèle ;
-   prétendre qu'un contrôle d'humidité empêche à lui seul le
    débordement d'une rivière.

## 3. Exigences système

  -----------------------------------------------------------------------
  ID                Exigence          Priorité          Preuve
  ----------------- ----------------- ----------------- -----------------
  SYS-001           Simuler           Must              Courbe θ(t)
                    l'évolution de                      
                    l'humidité                          
                    volumique θ                         

  SYS-002           Centraliser les   Must              Script et
                    paramètres et                       documentation
                    leurs unités                        

  SYS-003           Rendre les        Must              Scénarios
                    profils d'entrée                    reproductibles
                    paramétrables                       

  SYS-004           Enregistrer       Must              Signaux exportés
                    séparément les                      
                    flux                                

  SYS-005           Contrôler les     Must              Tests
                    limites physiques                   automatiques
                    de l'état                           

  SYS-006           Calculer le       Must              Rapport numérique
                    résidu du bilan                     
                    hydrique                            

  SYS-007           Implémenter une   Must              Résultats de
                    commande de                         référence
                    référence                           

  SYS-008           Comparer au moins Must              Tableau
                    deux stratégies                     comparatif

  SYS-009           Définir au moins  Must              Catalogue de
                    dix scénarios                       tests

  SYS-010           Automatiser les   Must              Résumé de
                    critères                            campagne
                    PASS/FAIL lorsque                   
                    possible                            

  SYS-011           Générer les       Must              Scripts
                    figures par                         reproductibles
                    script                              

  SYS-012           Documenter les    Must              README
                    instructions de                     
                    lancement                           

  SYS-013           Distinguer        Must              Rapport final
                    vérification et                     
                    validation                          

  SYS-014           Identifier les    Must              Hypothèses
                    paramètres                          documentées
                    illustratifs                        

  SYS-015           Réaliser une      Should            Figures de
                    analyse de                          sensibilité
                    sensibilité                         

  SYS-016           Générer           Should            Rapport exporté
                    automatiquement                     
                    un rapport                          

  SYS-017           Ajouter une       Could             Démonstrateur
                    interface après                     
                    validation du                       
                    modèle                              
  -----------------------------------------------------------------------

Exigences non fonctionnelles : reproductibilité, lisibilité,
traçabilité, modularité, robustesse numérique, documentation des limites
et indication des versions logicielles requises.

## 4. Modèle dynamique simplifié

### 4.1 État

On considère une couche homogène de profondeur effective (Z_r). L'état
est la teneur volumique en eau :

\[ `\theta`{=tex}=`\frac{V_{\mathrm{eau}}}{V_{\mathrm{sol}}}`{=tex} \]

Elle s'exprime en m³/m³. L'hypothèse d'humidité uniforme dans la couche
est une approximation de premier niveau : un sol réel présente des
variations spatiales et verticales.

### 4.2 Bilan hydrique

\[ Z_r`\frac{d\theta}{dt}`{=tex}=P_e+I-ET-D_n-D_c-R \]

où : - (Z_r) : profondeur de la couche, mm ; - (P_e) : pluie
effectivement infiltrée dans la couche, mm/h ; - (I) : irrigation, mm/h
; - (ET) : évapotranspiration, mm/h ; - (D_n) : drainage naturel, mm/h
; - (D_c) : drainage contrôlé, mm/h ; - (R) : ruissellement ou flux
d'excès de surface, mm/h.

Le temps est exprimé en heures ; (Z_r d`\theta`{=tex}/dt) s'exprime donc
en mm/h. Dans la V1, on peut poser (P_e=P) et (R=0). Quand
l'infiltration limitée et le ruissellement seront ajoutés, éviter de
compter deux fois le même flux d'eau.

### 4.3 Évapotranspiration

\[
ET(`\theta`{=tex})=ET\_{`\max`{=tex}}`\operatorname{sat}`{=tex}\_{\[0,1\]}
`\left`{=tex}(`\frac{\theta-\theta_w}{\theta_{ref}-\theta_w}`{=tex}`\right`{=tex})
\]

La fonction de saturation borne le résultat entre 0 et 1.
(`\theta`{=tex}*w) est un seuil bas, (`\theta`{=tex}*{ref}) un niveau de
référence et (ET\_{`\max`{=tex}}) le flux maximal du modèle. Cette loi
est pédagogique et ne remplace pas un modèle agronomique calibré.

### 4.4 Drainage naturel

\[
D_n(`\theta`{=tex})=D\_{`\max`{=tex}}`\operatorname{sat}`{=tex}\_{\[0,1\]}
`\left`{=tex}(`\frac{\theta-\theta_{fc}}{\theta_{sat}-\theta_{fc}}`{=tex}`\right`{=tex})
\]

Le drainage est nul sous (`\theta`{=tex}*{fc}), puis augmente jusqu'à
(D*{`\max`{=tex}}). C'est une approximation, pas une loi universelle du
drainage.

### 4.5 Actionneurs simulés

\[ I=u_i I\_{`\max`{=tex}},`\quad `{=tex}u_i`\in[0,1]`{=tex}\]

\[ D_c=u_dD\_{c,`\max`{=tex}}`\operatorname{sat}`{=tex}\_{\[0,1\]}
`\left`{=tex}(`\frac{\theta-\theta_d}{\theta_{sat}-\theta_d}`{=tex}`\right`{=tex})
\]

Les commandes (u_i) et (u_d) peuvent être binaires en V1. Le drainage
contrôlé est une abstraction de capacité d'évacuation et ne garantit pas
la protection contre une inondation fluviale.

### 4.6 Limites et bilan de masse

\[ 0`\leq`{=tex}`\theta`{=tex}`\leq`{=tex}`\theta`{=tex}\_{sat} \]

Ne pas se contenter de placer un bloc Saturation après l'intégrateur :
il peut masquer un bilan incohérent. Surveiller les flux, empêcher un
assèchement au-delà de l'eau disponible, traiter les apports
excédentaires et enregistrer chaque activation de limite.

Le résidu de conservation peut être calculé par :

\[
e_M(t)=Z_r\[`\theta`{=tex}(t)-`\theta`{=tex}(0)\]-`\int`{=tex}\_0\^t(P_e+I-ET-D_n-D_c-R),d`\tau`{=tex}
\]

Le résidu doit tendre vers zéro à la précision numérique près. La
tolérance doit être établie par des tests de convergence du solveur et
du pas d'intégration.

## 5. Paramètres de démonstration

Les valeurs sont des hypothèses de démarrage, pas des mesures des
parcelles familiales.

  Paramètre                   Valeur initiale Unité   Statut
  ------------------------- ----------------- ------- -------------------------
  (Z_r)                                   300 mm      Illustratif
  (`\theta`{=tex}\_0)                    0,25 m³/m³   Condition initiale
  (`\theta`{=tex}\_{sat})                0,45 m³/m³   Illustratif
  (`\theta`{=tex}\_{fc})                 0,30 m³/m³   Illustratif
  (`\theta`{=tex}\_w)                    0,12 m³/m³   Illustratif
  (`\theta`{=tex}\_{ref})                0,30 m³/m³   Illustratif
  (ET\_{`\max`{=tex}})                  0,125 mm/h    3 mm/jour, illustratif
  (D\_{`\max`{=tex}})                       5 mm/h    À étudier
  (I\_{`\max`{=tex}})               À définir mm/h    Selon actionneur simulé
  (D\_{c,`\max`{=tex}})             À définir mm/h    Selon capacité simulée

Vérifier :
(0`\leq`{=tex}`\theta`{=tex}*w\<`\theta`{=tex}*{fc}\<`\theta`{=tex}*{sat})
et
(`\theta`{=tex}*w\<`\theta`{=tex}*{ref}`\leq`{=tex}`\theta`{=tex}*{sat}).

## 6. Premier scénario ST-001 --- pluie puis sécheresse

**But :** vérifier la réponse du modèle à un épisode pluvieux suivi
d'une période sèche et contrôler le bilan hydrique.

-   Durée totale : 76 h.
-   État initial : (`\theta`{=tex}(0)=0,25).
-   Pluie : 15 mm/h de t = 0 à 4 h, puis 0 mm/h.
-   Irrigation et drainage contrôlé : désactivés.
-   Évapotranspiration et drainage naturel : actifs.
-   Pluie totale imposée : 60 mm.

À titre de référence idéale, 60 mm retenus dans une couche de 300 mm
correspondraient à une hausse de teneur volumique de 0,20 si toutes les
pertes étaient négligées. Ce n'est pas la prédiction du modèle complet.

### Critères d'acceptation

  -----------------------------------------------------------------------
  ID                      Critère                 Vérification
  ----------------------- ----------------------- -----------------------
  AT-001                  Aucune valeur NaN ou    Assertions MATLAB
                          Inf                     

  AT-002                  État dans les limites   Analyse des signaux
                          physiques, à la         
                          tolérance près          

  AT-003                  Résidu de bilan         Calcul indépendant
                          inférieur à une         
                          tolérance justifiée     

  AT-004                  Hausse pendant la pluie Comparaison avant/après
                          si l'apport net est     
                          positif                 

  AT-005                  Baisse pendant la       Analyse des flux et de
                          période sèche si les    la pente
                          pertes nettes sont      
                          positives               

  AT-006                  Résultats               Relancer et comparer
                          reproductibles          
  -----------------------------------------------------------------------

Une cible initiale de résidu inférieur à (10\^{-3}) mm peut être testée,
mais elle ne doit pas être déclarée valide sans essais de convergence et
examen des discontinuités.

## 7. Architecture MATLAB / Simulink

Sous-systèmes Simulink : - `Rainfall_Input` - `Irrigation_Input` -
`Evapotranspiration` - `Natural_Drainage` - `Controlled_Drainage` -
`Water_Balance` - `State_Limits_and_Diagnostics` - `Logging_and_Metrics`

Scripts MATLAB recommandés : - `init_parameters.m` : paramètres et
vérifications ; - `generate_scenario.m` : profil d'entrée identifié ; -
`run_scenario.m` : exécution ; - `compute_metrics.m` : indicateurs et
résidu ; - `plot_results.m` : figures ; - `run_all_tests.m` : campagne
complète ; - `export_report.m` : rapport si automatisé.

Arborescence cible :

``` text
AgroSim-Lab/
├── README.md
├── CHANGELOG.md
├── docs/
│   ├── cahier_des_charges.md
│   ├── model_assumptions.md
│   ├── architecture.md
│   ├── verification_validation_plan.md
│   ├── risk_register.md
│   └── decisions/
├── matlab/
├── simulink/AgroSimLab.slx
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── scenarios/
│   └── run_all_tests.m
├── results/figures/
└── reports/test_report.md
```

## 8. Campagne de tests minimale

  -----------------------------------------------------------------------
  ID                      Scénario                Objectif
  ----------------------- ----------------------- -----------------------
  ST-001                  Pluie puis période      Réponse de base et
                          sèche                   bilan

  ST-002                  Absence de pluie        Évapotranspiration
                          prolongée               

  ST-003                  Pluie faible            Réponse à un apport
                                                  modéré

  ST-004                  Pluie intense           Limite haute et
                                                  drainage

  ST-005                  État initial sec        Comportement près de la
                                                  limite basse

  ST-006                  État proche de          Comportement près de la
                          saturation              limite haute

  ST-007                  Irrigation active       Sens et amplitude de
                                                  l'action

  ST-008                  Drainage contrôlé actif Effet sur l'excès d'eau

  ST-009                  Paramètres modifiés     Sensibilité

  ST-010                  Pluie en paliers        Transitions et
                          rapprochés              robustesse numérique
  -----------------------------------------------------------------------

En V2, ajouter infiltration limitée, ruissellement, apport d'inondation
et mesure bruitée. Les scénarios non encore implémentés doivent rester
explicitement marqués comme tels.

## 9. Indicateurs de comparaison

Choisir les métriques avant les essais : - temps sous un seuil de
déficit hydrique ; - temps au-dessus d'un seuil d'excès d'eau ; - erreur
par rapport à une référence justifiée ; - irrigation cumulée ; -
drainage contrôlé cumulé ; - temps de réponse ; - nombre et durée des
activations ; - résidu du bilan hydrique ; - nombre de tests
réussis/échoués.

Les seuils hydriques dépendent du sol, de la culture et du stade de
croissance. Dans la V1, ils restent des paramètres de scénario, pas des
recommandations agricoles.

## 10. Stratégies de commande

### Baseline : seuils avec hystérésis

-   démarrer l'irrigation sous un seuil bas ;
-   arrêter l'irrigation au seuil haut ;
-   activer le drainage contrôlé au-dessus d'un seuil haut d'excès ;
-   prévenir les commutations rapides avec hystérésis et limites
    d'actionneurs.

### Stratégie améliorée

Après vérification de la baseline, choisir une logique mieux paramétrée,
une commande anticipative simple ou une commande prédictive (MPC) si les
outils et le temps le permettent. Comparer les stratégies sur les mêmes
conditions et avec les mêmes métriques. Une commande complexe n'est pas
automatiquement meilleure.

## 11. Roadmap sur six semaines

### Semaine 1 --- Modèle de référence

-   créer le dépôt et le journal de travail ;
-   centraliser paramètres et unités ;
-   implémenter pluie, évapotranspiration et drainage ;
-   construire le bilan hydrique ;
-   lancer ST-001 et tracer les flux. **Jalon G1 :** modèle exécutable
    et premières courbes.

### Semaine 2 --- Vérification numérique

-   tests de bornes et de paramètres ;
-   calcul indépendant du bilan ;
-   comparaison de solveurs/pas ;
-   analyse de sensibilité initiale. **Jalon G2 :** rapport de
    vérification.

### Semaine 3 --- Commande de référence

-   définir les seuils et hypothèses ;
-   implémenter l'hystérésis ;
-   ajouter les actionneurs simulés ;
-   tester les transitions et commutations. **Jalon G3 :** commande
    baseline testée.

### Semaine 4 --- Comparaison

-   choisir une seconde stratégie réaliste ;
-   figer les métriques avant les essais ;
-   exécuter les scénarios identiques ;
-   analyser les compromis et échecs. **Jalon G4 :** comparaison
    reproductible.

### Semaine 5 --- Campagne de validation

-   implémenter au moins dix scénarios ;
-   automatiser PASS/FAIL ;
-   construire la matrice exigences--tests--résultats ;
-   produire les figures et le rapport. **Jalon G5 :** campagne
    reproductible.

### Semaine 6 --- Livraison portfolio

-   nettoyer le modèle et les scripts ;
-   finaliser README, hypothèses et limites ;
-   générer les figures et une courte vidéo ;
-   vérifier la reproductibilité ;
-   préparer une présentation de cinq minutes. **Jalon G6 :** version
    `v1.0.0` publiable.

Le calendrier est indicatif. En cas de retard, réduire le périmètre
plutôt que publier des fonctionnalités non vérifiées.

## 12. Méthode professionnelle de discipline

### Cycle de travail

Pour chaque tâche : **exigence → conception → implémentation → test →
preuve → revue**. Chaque tâche doit produire un résultat observable. «
Travailler sur Simulink » est trop vague ; « vérifier le drainage pour
trois niveaux d'humidité » est actionnable.

### Routine quotidienne (60 à 120 minutes)

**Avant :** relire le jalon, choisir une tâche principale, définir la
preuve de fin.\
**Pendant :** travailler par blocs de 25--50 minutes, noter les
hypothèses et ne changer qu'une variable à la fois pendant le
diagnostic.\
**Après :** lancer le test, enregistrer le résultat, mettre à jour le
journal et écrire la prochaine action.

Modèle de journal :

``` text
Date :
Objectif :
Tâche réalisée :
Fichiers modifiés :
Test exécuté :
Résultat observé :
Problème restant :
Décision / hypothèse :
Prochaine action :
```

### Revue hebdomadaire

En début de semaine : sélectionner 3 à 5 tâches, un jalon et les
dépendances. En fin de semaine : vérifier les preuves, exécuter la suite
de tests, revoir les risques, archiver les résultats et planifier la
suite. Mesurer la progression par les jalons, pas par le nombre d'heures
ou de lignes de code.

### Kanban

Colonnes : `Backlog`, `Ready`, `In Progress`, `Review/Test`, `Done`,
`Blocked`. Limiter `In Progress` à une tâche principale. Une tâche ne
passe à `Done` que si elle est testée, documentée et reproductible.

### Definition of Done

-   besoin associé clair ;
-   implémentation réalisée ;
-   test passé ou échec expliqué ;
-   unités et hypothèses documentées ;
-   résultats reproductibles ;
-   documentation mise à jour ;
-   aucun échec connu dissimulé.

### Décisions et changements

Pour une décision importante, noter contexte, options, décision,
justification, conséquences et date. Toute modification du périmètre
doit indiquer l'impact sur le calendrier et les tests.

## 13. Versionnement et assurance qualité

Utiliser Git : - `main` pour la version stable ; - branches de
fonctionnalité pour le modèle, la commande et les tests ; - tags aux
jalons, par exemple `v0.1-model`, `v0.2-controller`, `v1.0.0`.

Exemples de commits : - `feat: add soil water balance model` -
`test: add ST-001 rainfall and dry-period scenario` -
`fix: correct drainage unit conversion` -
`docs: document model assumptions`

Avec MATLAB Unit Test (`matlab.unittest`) si disponible : - tests
unitaires pour les fonctions ; - tests d'intégration pour les
sous-systèmes ; - tests système sur les scénarios ; - tests de
régression après une modification.

Maintenir une matrice
`exigence → sous-système → test → résultat → preuve`. Une exigence non
testée doit être marquée non vérifiée. Conserver l'historique des échecs
et leur résolution.

## 14. Logiciels et outils

### Essentiels

-   **MATLAB :** calcul, scénarios, analyse, métriques, graphiques et
    automatisation.
-   **Simulink :** modèle dynamique modulaire et simulation.
-   **Git/GitHub :** versionnement et portfolio.
-   **Markdown :** cahier des charges, journal, rapport et README.
-   **MATLAB Projects :** organisation du projet et chemins.

### Toolboxes utiles si la licence les inclut

-   **Simulink Test :** gestion de scénarios, exécution et rapports de
    tests.
-   **Simulink Requirements :** traçabilité exigences--tests.
-   **Simulink Design Verifier :** analyse de propriétés et recherche de
    cas limites.
-   **Simulink Control Design :** analyse et conception de commande.
-   **Model Predictive Control Toolbox :** MPC, uniquement si cette
    stratégie est retenue.
-   **MATLAB Report Generator :** génération de rapports.

Vérifier la disponibilité réelle des toolboxes via la licence de
l'école. La V1 doit rester faisable avec MATLAB et Simulink de base.

### Compléments facultatifs

-   **Python :** analyse indépendante et rapports, seulement après que
    le flux MATLAB fonctionne ;
-   **Excel/LibreOffice Calc :** matrice de tests et registre des
    risques ;
-   **diagrams.net (draw.io) :** architecture et schémas ;
-   **VS Code :** édition Markdown et Git ;
-   **Simulink Test / Requirements** ne doivent pas être des dépendances
    obligatoires si les licences ne sont pas disponibles.

Éviter d'ajouter une interface, du cloud, de l'IoT ou plusieurs langages
avant d'avoir un modèle validé. La compétence centrale est de mener le
cycle modèle--simulation--test--analyse--preuve.

## 15. Compétences à acquérir

### Niveau 1 --- Fondations

-   unités et analyse dimensionnelle ;
-   équations différentielles et intégration numérique ;
-   fonctions et scripts MATLAB ;
-   blocs, sous-systèmes, paramètres et signaux Simulink ;
-   interprétation des courbes.

### Niveau 2 --- Modélisation

-   solveurs continus/discrets ;
-   discontinuités et saturations ;
-   initialisation des états ;
-   bilan de masse ;
-   analyse de sensibilité ;
-   distinction entre erreur de modèle et erreur numérique.

### Niveau 3 --- Commande

-   boucles ouvertes/fermées ;
-   seuils et hystérésis ;
-   réponse transitoire et stabilité à un niveau adapté ;
-   comparaison objective des commandes ;
-   MPC en extension, pas comme prérequis.

### Niveau 4 --- Test et validation

-   exigences testables ;
-   tests unitaires, intégration et système ;
-   critères d'acceptation ;
-   régression ;
-   traçabilité d'anomalies ;
-   reproductibilité ;
-   limites de validité du modèle.

### Niveau 5 --- Pratiques d'ingénierie

-   Git ;
-   documentation technique en anglais ;
-   rapports et figures avec unités ;
-   communication des hypothèses, incertitudes et limites ;
-   présentation orale des choix techniques.

## 16. Registre initial des risques

  -----------------------------------------------------------------------
  Risque                  Niveau                  Réponse
  ----------------------- ----------------------- -----------------------
  Périmètre trop          Élevé                   Une couche et un état
  ambitieux                                       en V1

  Paramètres peu          Élevé                   Les identifier comme
  réalistes                                       hypothèses,
                                                  sensibilité, références

  Saturation masquant une Élevé                   Calcul indépendant du
  erreur                                          bilan et journalisation

  Trop d'outils           Moyen                   MATLAB/Simulink et Git
                                                  d'abord

  Pas de données de       Moyen                   Revendiquer seulement
  terrain                                         des résultats simulés

  PFE prioritaire et      Élevé                   Jalons hebdomadaires,
  temps limité                                    candidatures en
                                                  parallèle

  Résultats non           Élevé                   Scripts, paramètres
  reproductibles                                  centralisés et versions

  Stratégie complexe sans Moyen                   Métriques définies
  gain                                            avant les essais
  -----------------------------------------------------------------------

## 17. Livrables finaux du portfolio

1.  dépôt GitHub propre ;
2.  README en anglais ;
3.  schéma d'architecture ;
4.  modèle Simulink et scripts MATLAB ;
5.  catalogue de tests et matrice de traçabilité ;
6.  rapport de vérification et de comparaison ;
7.  figures lisibles avec unités ;
8.  vidéo courte de démonstration ;
9.  résumé CV d'une page ;
10. présentation orale de cinq minutes.

Formulation CV possible **uniquement après réalisation effective** :

> Développement d'un environnement MATLAB/Simulink de modélisation et de
> validation d'un bilan hydrique simplifié ; conception de scénarios
> reproductibles, vérification du bilan de masse et comparaison de
> stratégies de commande à l'aide d'indicateurs de performance.

Ne pas annoncer de gains chiffrés sans mesures reproductibles et
expliquées dans le rapport.

## 18. Checklist --- trois premières sessions

### Session 1

-   [ ] Créer le dépôt GitHub.
-   [ ] Créer l'arborescence.
-   [ ] Copier ce document dans `docs/cahier_des_charges.md`.
-   [ ] Créer `init_parameters.m`.
-   [ ] Vérifier les toolboxes disponibles.

### Session 2

-   [ ] Définir les paramètres avec unités.
-   [ ] Implémenter le profil de pluie.
-   [ ] Implémenter l'évapotranspiration.
-   [ ] Implémenter le drainage naturel.
-   [ ] Construire le bilan hydrique dans Simulink.

### Session 3

-   [ ] Exécuter ST-001.
-   [ ] Enregistrer humidité, pluie et flux.
-   [ ] Tracer les résultats avec titres et unités.
-   [ ] Calculer le résidu de bilan.
-   [ ] Documenter les résultats, anomalies et prochaine action.

## 19. Principe directeur

Ne cherche pas à faire un projet spectaculaire dès le premier jour.
Construis un modèle simple dont chaque équation est comprise, chaque
hypothèse est explicitée et chaque comportement important est démontré
par des tests. La discipline --- exigences, modèle, essais, preuves,
documentation et analyse critique --- donnera à AgroSim Lab sa valeur
pour les métiers de simulation, validation et ingénierie des systèmes.

------------------------------------------------------------------------

*Fin du cahier des charges --- à réviser à chaque jalon majeur.*
