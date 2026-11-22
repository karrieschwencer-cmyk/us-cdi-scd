This page describes the profiles defined in this Implementation Guide. Each heading links to the formal profile definition, which lists every element, its cardinality, Must Support flags and terminology bindings. For help reading a profile page, see [How to Read This Guide](introduction.html#how-to-read-this-guide).

All profiles except one extend a [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/) profile and inherit its requirements. The exception is the USCDI-SCD BiologicallyDerivedProduct profile, which is based directly on the FHIR R4 resource because US Core has no equivalent profile. In every clinical profile, the reference to the patient is constrained to the USCDI-SCD Patient profile, so that a diagnosis, encounter or lab result always points to a USCDI-SCD Patient. Many other references, such as the encounter, the reason and the performer, are constrained to the corresponding USCDI-SCD profiles.

For how these profiles are used together in an exchange, see [Exchange Workflow](workflow.html). For where each USCDI+ SCD data element is represented, see [USCDI+ SCD Data Elements](uscdi-plus.html).

Example instances for each profile are listed on the [Examples](examples.html) page.

---

### Administrative and Demographic Profiles

These profiles identify the patient, providers, organizations and care locations involved in SCD care. Most add no constraints beyond US Core. They exist so that every other profile in this guide can reference a consistent USCDI-SCD version.

#### [USCDI-SCD Patient](StructureDefinition-uscdi-scd-patient.html)
Represents a person with, or at risk for, sickle cell disease. Race and ethnicity (the US Core Race and US Core Ethnicity extensions) are Must Support in this profile. Telecom and preferred language (`communication`) are also Must Support, so that care teams can reach patients and their caregivers.

#### [USCDI-SCD Practitioner](StructureDefinition-uscdi-scd-practitioner.html)
Represents a provider involved in SCD care, such as a hematologist, emergency physician, primary care provider, pain specialist or transfusion medicine physician. It adds no constraints to US Core Practitioner.

#### [USCDI-SCD PractitionerRole](StructureDefinition-uscdi-scd-practitionerrole.html)
Represents a provider's role at a specific organization and location. SCD care teams can span specialties and organizations, such as hematology, primary care, emergency medicine, social work, pain management and care coordination. It adds no constraints to US Core PractitionerRole.

#### [USCDI-SCD Organization](StructureDefinition-uscdi-scd-organization.html)
Represents an organization providing SCD care, such as a comprehensive SCD treatment center, hematology practice, Federally Qualified Health Center or hospital. It adds no constraints to US Core Organization.

#### [USCDI-SCD Location](StructureDefinition-uscdi-scd-location.html)
Represents a place where SCD care is delivered, such as an emergency department, outpatient hematology clinic, day hospital or infusion center (for chronic transfusion), or inpatient unit. It adds no constraints to US Core Location.

---

### Encounter Profile

#### [USCDI-SCD Encounter](StructureDefinition-uscdi-scd-encounter.html)
Represents a visit, such as an emergency visit for a vaso-occlusive crisis, a scheduled transfusion, an outpatient hematology visit or an admission for stem cell transplantation. The encounter's diagnoses (`diagnosis.condition` and `diagnosis.use`) are Must Support, so the reason for the visit is clearly linked. The reason for the encounter can reference an SCD diagnosis, procedure or lab result.

---

### Clinical Condition Profiles

SCD diagnoses are split into two profiles, following the US Core pattern: one for the long-term problem list and one for diagnoses made during a specific visit.

#### [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html)
Represents entries on the patient's problem list, most importantly the primary SCD diagnosis, including the SCD subtype (for example HbSS, HbSC or HbS-β⁰-thalassemia), along with chronic complications. The subtype is recorded in the diagnosis code itself; the [SCD Diagnosis Value Set](ValueSet-scd-diagnosis-vs.html) lists codes for each subtype. This is a reference list and does not constrain exchange; ONC maintains the SCD-relevant values in [USCDI+](uscdi-plus.html) (data element: Problems). Who recorded and who asserted the condition, and the supporting evidence, are Must Support. Laboratory results that the diagnosis is based on, such as a newborn screening result or a hemoglobin fractionation, are linked by referencing them in `Condition.evidence.detail`.

#### [USCDI-SCD Condition Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html)
Represents an acute diagnosis made during a visit, such as a vaso-occlusive crisis, acute chest syndrome, splenic sequestration or stroke. Clinical and verification status, onset, resolution (`abatement`) and evidence are Must Support. Codes for acute complications are listed in the [SCD Acute Complication Value Set](ValueSet-scd-acute-complication-vs.html). This is a reference list and does not constrain exchange; ONC maintains the SCD-relevant values in [USCDI+](uscdi-plus.html) (data element: Problems).

---

### Medication Profiles

#### [USCDI-SCD Medication](StructureDefinition-uscdi-scd-medication.html)
Represents a medication used in SCD care, coded with RxNorm. This includes disease-modifying therapies (hydroxyurea, L-glutamine, crizanlizumab), gene therapies (exagamglogene autotemcel, lovotibeglogene autotemcel), iron chelation (deferasirox, deferoxamine, deferiprone), analgesics, anticoagulants and infection prophylaxis (penicillin). Commonly used codes are listed in the [SCD Medication Value Set](ValueSet-scd-medication-vs.html). This is a reference list and does not constrain exchange; ONC maintains the SCD-relevant values in [USCDI+](uscdi-plus.html) (data element: Medications).

#### [USCDI-SCD MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html)
Represents a prescription or medication order, linking a medication to the patient, prescriber, dosage and reason. For iron chelation prescriptions, the [SCD Iron Chelation Indication](StructureDefinition-scd-iron-chelation-indication.html) extension documents the indication and the ferritin or liver iron value that triggered therapy.

---

### Allergy and Intolerance Profile

#### [USCDI-SCD AllergyIntolerance](StructureDefinition-uscdi-scd-allergyintolerance.html)
Represents drug allergies, intolerances and adverse reactions, including transfusion reactions. These matter in SCD care. NSAIDs can be nephrotoxic, and the [NHLBI 2014 expert panel report](references.html#nhlbi-2014) notes that acute renal failure can occur when people with sickle cell nephropathy are exposed to them. Opioid reactions affect pain management. The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) addresses delayed hemolytic transfusion reactions in people with SCD who receive transfusions. Type, category, criticality, onset and reaction details are Must Support.

---

### Care Planning and Coordination Profiles

#### [USCDI-SCD CarePlan](StructureDefinition-uscdi-scd-careplan.html)
Represents a structured care plan, such as a chronic transfusion plan, a medication adherence plan, an individualized pain management plan or a transition-of-care plan. The plan's period, author, care team, goals, activities and the conditions it addresses are Must Support.

#### [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html)
Represents a referral or order, such as a referral to hematology, pain management or a stem cell transplant program, or an order for a transfusion, lab test or imaging. Performer and reason are Must Support. A transfusion order is the link between the transfusion procedure and the blood product used (see below).

---

### Procedure Profile

#### [USCDI-SCD Procedure](StructureDefinition-uscdi-scd-procedure.html)
Represents procedures performed for SCD, including simple and exchange transfusions, stem cell transplantation, splenectomy, venous access port placement and monitoring procedures such as transcranial Doppler screening. Performer and reason are Must Support. Common codes are listed in the [SCD Procedure Value Set](ValueSet-scd-procedure-vs.html). This is a reference list and does not constrain exchange; ONC maintains the SCD-relevant values in [USCDI+](uscdi-plus.html) (data element: Procedures).

For transfusions, the procedure SHOULD reference the transfusion order in `basedOn`. FHIR R4 does not allow `Procedure.usedReference` to reference a BiologicallyDerivedProduct. So the units transfused are linked through the order: `Procedure.basedOn` references the ServiceRequest, and each blood product's `BiologicallyDerivedProduct.request` references the same ServiceRequest. `Procedure.usedReference` is for medications or devices used during the procedure, where relevant; this profile allows USCDI-SCD Medication and Device. Whether `basedOn` should be Must Support, and whether `usedReference` should remain Must Support, is an open question ([OQ-20](issues.html#oq-20)).

---

### Observation Profiles

#### [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html)
Represents laboratory results used to monitor SCD, including:

- Complete blood count and reticulocyte count
- Hemoglobin fractionation (HbS %, HbF %, HbA2 %). HbF is monitored for response to hydroxyurea ([NHLBI 2014](references.html#nhlbi-2014)), and HbS is kept below a target level during chronic transfusion for stroke prevention ([ASH 2020 cerebrovascular guideline](references.html#ash-2020-cerebrovascular))
- Hemolysis markers (LDH, bilirubin)
- Iron studies (ferritin), for iron overload monitoring ([ASH 2020 transfusion guideline](references.html#ash-2020-transfusion))
- Kidney and liver function
- Red cell antigen typing and antibody screening before transfusion

Reference ranges and components are Must Support, so that panels like hemoglobin fractionation can report each value. Common LOINC codes are listed in the [SCD Laboratory Panel Value Set](ValueSet-scd-laboratory-panel-vs.html). This is a reference list and does not constrain exchange; ONC maintains the SCD-relevant values in [USCDI+](uscdi-plus.html) (data element: Tests).

#### [USCDI-SCD Vital Signs](StructureDefinition-uscdi-scd-vital-signs.html)
Represents vital signs, with emphasis on measurements used in SCD care:

- Oxygen saturation (SpO2). The [NHLBI 2014 expert panel report](references.html#nhlbi-2014) calls for pulse oximetry when evaluating a patient for acute chest syndrome, and for oxygen when SpO2 is below 95% on room air during a vaso-occlusive crisis
- Pain severity score (0–10), used to assess vaso-occlusive crises
- Temperature. The NHLBI 2014 report calls for immediate evaluation of a temperature of 38.5 °C (101.3 °F) or higher, because of the risk of severe bacterial infection
- Blood pressure. The [ASH 2019 cardiopulmonary and kidney guideline](references.html#ash-2019-cardiopulmonary-kidney) recommends a goal below 130/80 mm Hg (as amended by its [2023 correction](references.html#ash-2019-cardiopulmonary-kidney-correction)) for adults with SCD
- Respiratory rate. Tachypnea is one of the signs that the NHLBI 2014 report lists for evaluating acute chest syndrome

Codes are listed in the [SCD Vital Signs Value Set](ValueSet-scd-vital-signs-vs.html). This is a reference list, shown on the profile page as an Additional Binding, and does not constrain exchange; the US Core vital signs bindings apply. Pain scores are profiled here as vital signs, which is an open question ([OQ-22](issues.html#oq-22)).

---

### Biologically Derived Product Profile

#### [USCDI-SCD BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html)
Represents a blood product, such as packed red blood cells or hematopoietic progenitor cells for transplantation. This is the only profile in this guide with no US Core parent; it is based directly on the FHIR R4 BiologicallyDerivedProduct resource.

Red cell transfusion remains a mainstay of SCD therapy. The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) reports that red cell alloimmunization (forming antibodies to donor red cells) is more common in SCD than in any other transfused patient population, and recommends red cells matched for the Rh (C, E or C/c, E/e) and K antigens. This profile records the product type, the order it fulfills (`request`), collection, processing steps (such as leukoreduction and antigen matching) and storage, all as Must Support. Two extensions add SCD-specific detail: [SCD Transfusion Red Cell Antigen Match](StructureDefinition-scd-transfusion-antigen-match.html) and [SCD Blood Product Age at Transfusion](StructureDefinition-scd-blood-product-age.html).

The FHIR R4 version of this resource is limited. It has no direct link to the patient who received the product, and transfusion procedures cannot reference it directly. This guide links products to patients and procedures through the transfusion order (ServiceRequest) ([KI-5](issues.html#ki-5)). In FHIR R5, `Procedure.used` can reference a BiologicallyDerivedProduct directly.
