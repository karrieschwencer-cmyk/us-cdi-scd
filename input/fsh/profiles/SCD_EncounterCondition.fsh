// ==============================================================================
// USCDI-SCD FSH Profiles — Encounter and Conditions
// File: input/fsh/profiles/SCD_EncounterCondition.fsh
//
// Profiles:
//   - SCDEncounter
//   - SCDConditionEncounterDiagnosis
//   - SCDConditionProblemsAndHealthConcerns
// ==============================================================================


// ==============================================================================
// SCDEncounter
// ==============================================================================
// Extends: US Core Encounter Profile
// Purpose: Represents encounters for people with SCD, including:
//   - Emergency department visits (vaso-occlusive crisis, ACS)
//   - Outpatient hematology visits
//   - Day hospital / infusion center visits (transfusion)
//   - Inpatient admissions (ACS, stroke, HSCT)
// ==============================================================================

Profile: SCDEncounter
Parent: us-core-encounter
Id: uscdi-scd-encounter
Title: "USCDI-SCD Encounter"
Description: """
  The USCDI-SCD Encounter profile represents a clinical encounter for a patient
  with Sickle Cell Disease. This profile extends the
  [US Core Encounter Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-encounter.html).

  People with SCD frequently present across multiple care settings. Common SCD
  encounter types include:
  - **Emergency visits** for vaso-occlusive crisis (VOC), acute chest syndrome
    (ACS), fever/infection, splenic sequestration, and priapism
  - **Outpatient hematology visits** for disease monitoring and medication
    management
  - **Day hospital / infusion center visits** for chronic transfusion therapy
    (simple and exchange transfusion)
  - **Inpatient admissions** for severe VOC, ACS, stroke, or hematopoietic
    stem cell transplantation (HSCT)

  The reason for encounter (reasonCode or reasonReference) SHOULD reference a
  USCDI-SCD Condition where applicable. Blood products transfused during the
  encounter are linked through the transfusion order (ServiceRequest), because
  FHIR R4 Encounter has no element for them.
"""

* ^status = #draft
* ^purpose = "Records SCD-related encounters, such as emergency department visits for vaso-occlusive crisis, for the SCD Emergency Care use case."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Encounter
* identifier MS
* status MS
* class MS
* type MS
* subject MS
* subject only Reference(SCDPatient)
* participant MS
* participant.individual MS
* participant.individual only Reference(SCDPractitioner or SCDPractitionerRole)
* period MS
* reasonCode MS
* reasonReference MS
* reasonReference only Reference(SCDConditionEncounterDiagnosis or SCDConditionProblemsAndHealthConcerns or SCDProcedure or SCDObservationLaboratoryResult)
* diagnosis MS
* diagnosis.condition MS
* diagnosis.use MS
* hospitalization MS
* hospitalization.dischargeDisposition MS
* location MS
* location.location MS
* location.location only Reference(SCDLocation)
* serviceProvider MS
* serviceProvider only Reference(SCDOrganization)

// TODO: Decide whether to bind reasonCode to an SCD encounter reason value set (OQ-15).


// ==============================================================================
// SCDConditionEncounterDiagnosis
// ==============================================================================
// Extends: US Core Condition Encounter Diagnosis Profile
// Purpose: Represents acute diagnoses documented during an SCD-related
//          encounter (e.g., vaso-occlusive crisis, acute chest syndrome,
//          stroke, splenic sequestration, priapism, fever in SCD).
// ==============================================================================

Profile: SCDConditionEncounterDiagnosis
Parent: us-core-condition-encounter-diagnosis
Id: uscdi-scd-condition-encounter-diagnosis
Title: "USCDI-SCD Condition Encounter Diagnosis"
Description: """
  The USCDI-SCD Condition Encounter Diagnosis profile represents an acute
  diagnosis documented during an encounter for a patient with Sickle Cell Disease.
  This profile extends the
  [US Core Condition Encounter Diagnosis Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-condition-encounter-diagnosis.html).

  Common acute SCD encounter diagnoses represented by this profile include:
  - Vaso-occlusive crisis (VOC) / Acute Pain Episode
    (ICD-10-CM "with crisis, unspecified": D57.00, D57.219, D57.419, D57.439,
    D57.459, D57.819)
  - Acute Chest Syndrome (ACS)
    (ICD-10-CM: D57.01, D57.211, D57.411, D57.431, D57.451, D57.811)
  - Splenic sequestration
    (ICD-10-CM: D57.02, D57.212, D57.412, D57.432, D57.452, D57.812)
  - Stroke / Cerebrovascular accident in SCD
    (ICD-10-CM "with cerebral vascular involvement": D57.03, D57.213, D57.413,
    D57.433, D57.453, D57.813)
  - Priapism in SCD
  - Fever / sepsis in a person with SCD
  - Acute kidney injury in SCD
  - Acute hepatic sequestration

  `Condition.code` follows the US Core binding (preferred: SNOMED CT or
  ICD-10-CM). Where both codes are available, sending both as separate
  `Condition.code.coding` entries helps receiving systems.
"""

* ^status = #draft
* ^purpose = "Records diagnoses made during an SCD-related encounter, such as an acute complication, for the SCD Emergency Care use case."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Condition Encounter Diagnosis
* clinicalStatus MS
* verificationStatus MS
* category MS
* code MS
* code ^short = "Acute SCD diagnosis code (SNOMED CT or ICD-10-CM)"
// Restates the US Core additional binding so it is kept when this profile adds its own.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "us-core-condition-code-current"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #current
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = "http://hl7.org/fhir/us/core/ValueSet/us-core-condition-code-current"
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "US Core uses the current additional binding for encoding newly recorded, non-legacy problem list items, health concerns and diagnosis"
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "Required for new records"
// Non-constraining reference binding (purpose starter): adds no requirement beyond
// the US Core binding, which still applies.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "scd-diagnosis-reference"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #starter
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(SCDDiagnosisVS)
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "Reference list of SCD diagnosis codes commonly used in SCD care. It does not constrain exchange; the US Core binding applies. ONC maintains the SCD-relevant values for the USCDI+ Problems data element in USCDI+ ([SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) lists)."
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "SCD diagnoses (USCDI+)"
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "scd-acute-complication-reference"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #starter
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(SCDAcuteComplicationVS)
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "Reference list of acute SCD complication codes commonly used in SCD care. It does not constrain exchange; the US Core binding applies. ONC maintains the SCD-relevant values for the USCDI+ Problems data element in USCDI+ ([SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) lists)."
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "SCD acute complications (USCDI+)"
* code ^comment = """
  For SCD encounter diagnoses, code SHOULD use SNOMED CT or ICD-10-CM.
  Where both are available, both SHOULD be included as coding repetitions.
  US Core's preferred binding applies. The SCD Acute Complication value set
  lists common acute SCD complications, for reference.
"""
* subject MS
* subject only Reference(SCDPatient)
* encounter MS
* encounter only Reference(SCDEncounter)
* onset[x] MS
* abatement[x] MS
* recordedDate MS
* evidence MS
// TODO: Project team to decide whether evidence.detail, rather than evidence.id, should be
// Must Support (OQ-11).
* evidence ^comment = """
  To link the diagnosis to the laboratory results it is based on (for example,
  a hemoglobin fractionation that confirms the SCD subtype), reference the
  USCDI-SCD Laboratory Result Observation in evidence.detail.
"""
* evidence.id MS



// ==============================================================================
// SCDConditionProblemsAndHealthConcerns
// ==============================================================================
// Extends: US Core Condition Problems and Health Concerns Profile
// Purpose: Represents the chronic SCD problem list, including:
//   - SCD diagnosis and subtype
//   - Chronic organ complications (avascular necrosis, CKD, retinopathy,
//     pulmonary hypertension, silent cerebral infarcts, iron overload)
//   - Psychosocial health concerns (depression, anxiety, chronic pain)
//   - Comorbidities managed alongside SCD
// ==============================================================================

Profile: SCDConditionProblemsAndHealthConcerns
Parent: us-core-condition-problems-health-concerns
Id: uscdi-scd-condition-problems
Title: "USCDI-SCD Condition Problems and Health Concerns"
Description: """
  The USCDI-SCD Condition Problems and Health Concerns profile represents
  active and resolved conditions on the problem list for a patient with Sickle
  Cell Disease. This profile extends the
  [US Core Condition Problems and Health Concerns Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-condition-problems-health-concerns.html).

  Key problem list entries for people with SCD represented by this profile:

  **SCD Diagnosis and Subtype:**
  - Sickle cell anemia (HbSS): SNOMED 127040003; ICD-10-CM D57.1 (without crisis)
  - Sickle cell–hemoglobin C disease (HbSC): SNOMED 35434009; ICD-10-CM D57.20 (without crisis)
  - Sickle cell–beta-0-thalassemia: SNOMED 127043001; ICD-10-CM D57.42 (without crisis)
  - Sickle cell–beta-plus-thalassemia: SNOMED 127042006; ICD-10-CM D57.44 (without crisis)
  - (Additional subtypes: see the SCD Diagnosis value set)

  **Chronic Complications:**
  - Avascular necrosis of femoral head in SCD
  - Chronic kidney disease (CKD) in SCD
  - Proliferative retinopathy in SCD
  - Pulmonary arterial hypertension in SCD
  - Silent cerebral infarction in SCD
  - Chronic iron overload (due to transfusion)
  - Leg ulcers in SCD
  - Priapism (recurrent)

  **Psychosocial Health Concerns:**
  - Chronic pain syndrome
  - Depression complicating SCD
  - Anxiety disorder in a person with SCD

  For a person with SCD, the primary SCD diagnosis, including the SCD subtype,
  is expected to be on the problem list; recording it is the aim of the SCD
  Diagnosis use case.
"""

* ^status = #draft
* ^purpose = "Records the SCD diagnosis with its subtype, and SCD complications, on the problem list, for the SCD Diagnosis and SCD Emergency Care use cases."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Condition Problems and Health Concerns
* clinicalStatus MS
* verificationStatus MS
* category MS
* code MS
* code ^short = "SCD diagnosis (with subtype) or chronic complication code"
// Restates the US Core additional binding so it is kept when this profile adds its own.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "us-core-condition-code-current"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #current
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = "http://hl7.org/fhir/us/core/ValueSet/us-core-condition-code-current"
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "US Core uses the current additional binding for encoding newly recorded, non-legacy problem list items, health concerns and diagnosis"
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "Required for new records"
// Non-constraining reference binding (purpose starter): adds no requirement beyond
// the US Core binding, which still applies.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "scd-diagnosis-reference"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #starter
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(SCDDiagnosisVS)
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "Reference list of SCD diagnosis codes commonly used in SCD care. It does not constrain exchange; the US Core binding applies. ONC maintains the SCD-relevant values for the USCDI+ Problems data element in USCDI+ ([SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) lists)."
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "SCD diagnoses (USCDI+)"
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "scd-acute-complication-reference"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #starter
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(SCDAcuteComplicationVS)
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "Reference list of acute SCD complication codes commonly used in SCD care. It does not constrain exchange; the US Core binding applies. ONC maintains the SCD-relevant values for the USCDI+ Problems data element in USCDI+ ([SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) lists)."
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "SCD acute complications (USCDI+)"
* code ^comment = """
  The code represents the problem or health concern: the SCD diagnosis, an SCD
  complication or another concern. For the primary SCD diagnosis, this SHOULD
  be the subtype-specific code (e.g., HbSS, HbSC).
  Use SNOMED CT or ICD-10-CM. Both SHOULD be included when available.
  US Core's preferred binding applies. The SCD Diagnosis value set lists SCD
  diagnosis codes, for reference. Any appropriate code may be used, including
  for chronic complications and other problems the value set does not cover.
"""
* subject MS
* subject only Reference(SCDPatient)
* onset[x] MS
* abatement[x] MS
* recordedDate MS
* recorder MS
* asserter MS
* evidence MS
// TODO: Project team to decide whether evidence.detail, rather than evidence.id, should be
// Must Support (OQ-11).
* evidence ^comment = """
  To link the diagnosis to the laboratory results it is based on (for example,
  a hemoglobin fractionation that confirms the SCD subtype), reference the
  USCDI-SCD Laboratory Result Observation in evidence.detail.
"""
* evidence.id MS

// SCD-specific extensions for the primary SCD diagnosis entry
* extension contains
    SCDVOCFrequencyExtension named scd-voc-frequency 0..1 MS and
    SCDNewbornScreenReferenceExtension named scd-newborn-screen-reference 0..1
* extension[scd-voc-frequency] ^short = "Frequency of vaso-occlusive crisis episodes"
* extension[scd-newborn-screen-reference] ^short = "Newborn screening result that identified SCD"
