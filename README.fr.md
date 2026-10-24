# AgroSim Lab

[English version](README.md)

Un laboratoire virtuel MATLAB/Simulink qui modélise l'humidité volumique d'une couche de sol et compare des stratégies de gestion de l'eau, avec un accent fort sur la **vérification, la validation et la traçabilité**.

> **Avertissement.** Tous les paramètres sont des **valeurs de démonstration illustratives**, pas des mesures de terrain. Ce projet est un modèle dynamique testable, pas un outil opérationnel d'aide à la décision agricole.

## Pourquoi ce projet

L'agriculture fait face à deux risques opposés : l'excès d'eau après de fortes pluies ou des inondations, et le déficit hydrique pendant les périodes sèches. AgroSim Lab étudie les deux avec un modèle simple et transparent, où chaque équation est comprise, chaque hypothèse documentée et chaque comportement démontré par des tests.

## Le modèle en une ligne

```text
Zr * d(theta)/dt = Pe + I - ET - Dn - Dc - R
```

| Symbole | Signification | Unité |
|---|---|---|
| theta | Teneur volumique en eau | m3/m3 |
| Zr | Profondeur effective de la couche | mm |
| Pe | Pluie infiltrée | mm/h |
| I | Irrigation | mm/h |
| ET | Évapotranspiration | mm/h |
| Dn / Dc | Drainage naturel / contrôlé | mm/h |
| R | Ruissellement | mm/h |

## Périmètre

| Version | Contenu | Statut |
|---|---|---|
| V1 | Modèle à un état, diagnostic du bilan de masse, commande à hystérésis, 10 scénarios | En cours |
| V2 | Ruissellement, inondation, sensibilité, commande améliorée | Prévu |
| V3 | Multicouche, mesure bruitée, données météo réelles | Facultatif |

## Feuille de route

| Jalon | Objectif | Statut |
|---|---|---|
| G0 | Dépôt et documentation de base | Terminé quand le tag v0.0-setup existe |
| G1 | Modèle exécutable et premières courbes | À faire |
| G2 | Rapport de vérification numérique | À faire |
| G3 | Commande de référence testée | À faire |
| G4 | Comparaison reproductible | À faire |
| G5 | Campagne de validation reproductible | À faire |
| G6 | Version v1.0.0 publiable | À faire |

## Prérequis

MATLAB et Simulink (base). Toolboxes facultatives : Simulink Test, Simulink Requirements, Simulink Design Verifier, Simulink Control Design, Model Predictive Control Toolbox, MATLAB Report Generator. La V1 doit fonctionner avec MATLAB et Simulink de base.

## Documentation

- [Cahier des charges](docs/cahier_des_charges.md)
- [Hypothèses du modèle](docs/model_assumptions.md)
- [Registre des risques](docs/risk_register.md)
- [Journal de travail](docs/worklog.md)

## Licence

MIT. Voir [LICENSE](LICENSE).