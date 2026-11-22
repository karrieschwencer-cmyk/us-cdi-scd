This guide defines six extensions for SCD-specific details that have no dedicated element in the FHIR R4 resources or US Core profiles it uses. Each heading links to the formal extension definition. All extensions are included in the FHIR package on the [Downloads](downloads.html) page.

### Summary

| Extension | Part of profile | Type | Purpose |
|---|---|---|---|
| [SCD Vaso-Occlusive Crisis Frequency](StructureDefinition-scd-voc-frequency.html) | [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) (MS) | Complex | How often VOC episodes occur |
| [SCD Newborn Screen Reference](StructureDefinition-scd-newborn-screen-reference.html) | [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html), [Patient](StructureDefinition-uscdi-scd-patient.html) | Reference | The newborn screening result that identified SCD |
| [SCD Iron Chelation Indication](StructureDefinition-scd-iron-chelation-indication.html) | [MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html) (MS) | Complex | Why iron chelation therapy was started |
| [SCD Transfusion Red Cell Antigen Match](StructureDefinition-scd-transfusion-antigen-match.html) | [BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) (MS), [Procedure](StructureDefinition-uscdi-scd-procedure.html) | Complex | Which red cell antigens were matched for a transfusion |
| [SCD Hydroxyurea Adherence](StructureDefinition-scd-hydroxyurea-adherence.html) | None yet (may be used on an Observation or MedicationStatement) | Complex | How consistently the patient takes hydroxyurea |
| [SCD Blood Product Age at Transfusion](StructureDefinition-scd-blood-product-age.html) | [BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) (MS) | Quantity (days) | How old the blood product was when transfused |

"Complex" extensions are made up of several named parts, described below. (MS) means the extension is Must Support in that profile.

---

### Diagnosis and Disease History

The SCD subtype (for example, HbSS, HbSC, HbS-β⁰-thalassemia or HbS-β⁺-thalassemia) does not need an extension. It is recorded in the diagnosis code itself (`Condition.code`), because each subtype has its own SNOMED CT and ICD-10-CM codes; see the [SCD Diagnosis Value Set](ValueSet-scd-diagnosis-vs.html). Laboratory results that the diagnosis is based on, such as a newborn screening result or a hemoglobin fractionation, are linked to the diagnosis by referencing them in `Condition.evidence.detail`. See [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html).

*Example:* [Condition — HbSS Sickle Cell Disease](Condition-maya-johnson-scd-diagnosis.html), which also uses the two extensions below.

#### [SCD Vaso-Occlusive Crisis Frequency](StructureDefinition-scd-voc-frequency.html)
Records how many vaso-occlusive crisis (VOC) episodes the patient had over a period of time. It is used on the Condition for the primary SCD diagnosis. VOC frequency informs treatment decisions. For example, the [NHLBI 2014 expert panel report](references.html#nhlbi-2014) recommends hydroxyurea for adults with sickle cell anemia who have three or more moderate to severe pain crises in a 12-month period, and the [ASH 2021 stem cell transplantation guideline](references.html#ash-2021-hsct) conditionally suggests matched related allogeneic transplant, rather than standard care, for patients with frequent pain.

| Part | Type | Description |
|---|---|---|
| `episodeCount` (required) | integer | Number of VOC episodes in the period |
| `observationPeriod` (required) | Period | The period over which episodes were counted |
| `measurementMethod` | CodeableConcept | How episodes were counted, such as self-report, chart review or hospitalization records |

#### [SCD Newborn Screen Reference](StructureDefinition-scd-newborn-screen-reference.html)
Links a patient, or their SCD diagnosis, to the newborn screening result that first identified SCD. The value references an Observation (such as a newborn hemoglobinopathy screening result) or a DiagnosticReport (the complete newborn screening report). It supports care coordination between state newborn screening programs, follow-up programs and ongoing clinical care.

This guide's guidance is to populate this extension on the Condition for the SCD diagnosis. Use it on the Patient only when no SCD Condition exists yet, for example for a newborn with a positive screen who is awaiting confirmatory testing.

*Example:* the [Condition — HbSS Sickle Cell Disease](Condition-maya-johnson-scd-diagnosis.html) uses this extension.

---

### Medications

#### [SCD Hydroxyurea Adherence](StructureDefinition-scd-hydroxyurea-adherence.html)
Records how consistently a patient takes hydroxyurea: the adherence level, how it was assessed and when. No profile in this guide uses it yet ([KI-7](issues.html#ki-7)). US Core 8.0.1 also defines a [Medication Adherence](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-medication-adherence.html) extension for MedicationRequest; whether to use it instead is an open question ([OQ-28](issues.html#oq-28)).

| Part | Type | Description |
|---|---|---|
| `adherenceLevel` | CodeableConcept | The adherence level, such as high, moderate, low or non-adherent |
| `adherenceMethod` | CodeableConcept | How adherence was assessed |
| `assessmentDate` | date | When adherence was assessed |

*Example:* [MedicationStatement — Hydroxyurea Adherence](MedicationStatement-maya-johnson-hydroxyurea-adherence.html)

#### [SCD Iron Chelation Indication](StructureDefinition-scd-iron-chelation-indication.html)
Records why iron chelation therapy was started for a patient with iron overload from chronic transfusion. The [deferasirox (Exjade) labeling](references.html#label-deferasirox) calls for evidence of chronic transfusional iron overload before starting therapy, including transfusion of at least 100 mL/kg of packed red blood cells and a serum ferritin consistently above 1,000 mcg/L. The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) suggests MRI screening of liver iron content every 1 to 2 years, rather than ferritin monitoring alone, for patients on chronic transfusion. This extension records the indication, the measure that triggered therapy and the value at which it was started. It is part of the [USCDI-SCD MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html) profile.

| Part | Type | Description |
|---|---|---|
| `indicationCode` | CodeableConcept | The reason for starting chelation, such as transfusion hemosiderosis |
| `triggerMeasurement` | CodeableConcept | The lab or imaging measure, such as serum ferritin or liver iron concentration |
| `triggerValue` | Quantity | The value at which chelation was started |

*Example:* [MedicationRequest — Deferasirox Iron Chelation](MedicationRequest-maya-johnson-deferasirox-request.html)

---

### Transfusion

#### [SCD Transfusion Red Cell Antigen Match](StructureDefinition-scd-transfusion-antigen-match.html)
Records which red cell antigens were matched when selecting blood for a transfusion. The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) reports that red cell alloimmunization (forming antibodies to donor red cells) is more common in SCD than in any other transfused patient population. It recommends prophylactic matching for the Rh (C, E or C/c, E/e) and K antigens, over ABO/RhD matching alone, for all patients with SCD who receive transfusions. It notes that extended matching for Jk<sup>a</sup>/Jk<sup>b</sup> (Kidd), Fy<sup>a</sup>/Fy<sup>b</sup> (Duffy) and S/s may provide further protection, and that extended-matched red cells should be considered if transfusion is needed during hyperhemolysis.

This extension is used on the blood product to record the antigens matched. It may also be used on the transfusion Procedure, to record the antigen matching used for the units transfused. The matching that was requested belongs on the transfusion order (ServiceRequest). Whether this extension should also be allowed on the order, and whether antigen matching should be recorded only with this extension or also with processing codes, is an open question ([OQ-20](issues.html#oq-20)).

| Part | Type | Description |
|---|---|---|
| `matchedAntigen` (repeating) | CodeableConcept | Each antigen that was matched (see the [SCD Red Cell Antigen Value Set](ValueSet-scd-red-cell-antigen-vs.html), example binding) |
| `matchingProtocol` | string | The matching protocol used, such as "Extended 5-antigen match" |

*Example:* [BiologicallyDerivedProduct — Antigen-Matched pRBCs](BiologicallyDerivedProduct-prbcs-antigen-matched-example.html)

#### [SCD Blood Product Age at Transfusion](StructureDefinition-scd-blood-product-age.html)
Records the age of a blood product, in days from collection to transfusion. Neither the [NHLBI 2014 expert panel report](references.html#nhlbi-2014) nor the [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) makes a recommendation on red cell storage age. The value is a quantity in days (UCUM unit `d`).

*Example:* [BiologicallyDerivedProduct — Antigen-Matched pRBCs](BiologicallyDerivedProduct-prbcs-antigen-matched-example.html)

---

### Extensions from Other Guides

USCDI-SCD profiles also inherit extensions from US Core, such as the US Core Race and Ethnicity extensions on Patient. See the [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/) guide for details.
