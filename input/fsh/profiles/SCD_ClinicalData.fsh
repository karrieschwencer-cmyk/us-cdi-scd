// ==============================================================================
// USCDI-SCD FSH Profiles — Procedure, Observations, and Biologically Derived Product
// File: input/fsh/profiles/SCD_ClinicalData.fsh
//
// Profiles:
//   - SCDProcedure
//   - SCDObservationLaboratoryResult
//   - SCDObservationVitalSigns
//   - SCDBiologicallyDerivedProduct
// ==============================================================================


// ==============================================================================
// SCDProcedure
// ==============================================================================
// Extends: US Core Procedure Profile
// Purpose: Represents procedures performed in the context of SCD care.
//
// Key SCD procedures:
//   - Simple red blood cell transfusion
//   - Automated red cell exchange (erythrocytapheresis) — exchange transfusion
//   - Phlebotomy (for iron overload management)
//   - Hematopoietic stem cell transplantation (HSCT) — bone marrow transplant
//   - Splenectomy (surgical or historical)
//   - Central venous access / implantable port placement
//   - Transcranial Doppler (TCD) ultrasound
//   - Hydroxyurea dose escalation (clinical act, not procedure per se)
// ==============================================================================

Profile: SCDProcedure
Parent: us-core-procedure
Id: uscdi-scd-procedure
Title: "USCDI-SCD Procedure"
Description: """
  The USCDI-SCD Procedure profile represents procedures performed on or for
  patients with Sickle Cell Disease. This profile extends the
  [US Core Procedure Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-procedure.html).

  SCD-specific procedures represented by this profile include:

  **Transfusion Procedures:**
  - Simple red blood cell transfusion (SNOMED: 116863004 or 71493000 / CPT: 36430)
  - Automated red cell exchange transfusion / erythrocytapheresis
    (SNOMED: 438839005 / CPT: 36512)

  **Definitive/Surgical Procedures:**
  - Hematopoietic stem cell transplantation (HSCT) / bone marrow transplant
  - Splenectomy (typically elective, after recurrent splenic sequestration)
  - Central venous catheter / implantable port placement

  **Monitoring/Diagnostic Procedures:**
  - Transcranial Doppler (TCD) ultrasound (stroke risk screening)
  - Echocardiogram (for patients with signs or symptoms of pulmonary
    hypertension; the ASH 2019 cardiopulmonary and kidney guideline suggests
    against routine screening echocardiography in asymptomatic patients)
  - Liver MRI (iron quantification — R2*/T2* technique)

  When `procedure.code` indicates a transfusion, the procedure SHOULD
  reference the transfusion order in `procedure.basedOn`. The
  SCDBiologicallyDerivedProduct instance(s) for the blood product(s) used
  reference the same order in `BiologicallyDerivedProduct.request`. (In FHIR R4,
  `procedure.usedReference` cannot reference BiologicallyDerivedProduct.)
"""

* ^status = #draft
* ^purpose = "Records SCD procedures, such as transfusions and hematopoietic stem cell transplants, for the SCD Emergency Care use case."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Procedure
* status MS
* code MS
* code ^short = "SCD procedure code (SNOMED CT or CPT)"
// Restates the US Core additional binding so it is kept when this profile adds its own.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "us-core-condition-code-current"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #current
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = "http://hl7.org/fhir/us/core/ValueSet/us-core-procedure-code"
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "US Core uses the current additional binding from FHIR R5 for this coded element for more flexibility when exchanging legacy and text-only data."
// Non-constraining reference binding (purpose starter): adds no requirement beyond
// the US Core binding, which still applies.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "scd-procedure-reference"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #starter
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(SCDProcedureVS)
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "Reference list of SCD procedure codes commonly used in SCD care. It does not constrain exchange; the US Core binding applies. ONC maintains the SCD-relevant values for the USCDI+ Procedures data element in USCDI+ ([SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) list)."
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "SCD procedures (USCDI+)"
* code ^comment = """
  For transfusion procedures, code SHOULD use SNOMED CT 116863004 or 71493000
  (simple transfusion) or 438839005 (automated red cell exchange). CPT codes
  MAY be included.
  US Core's preferred binding applies. The SCD Procedure value set lists
  common SCD procedures, for reference.
"""
* subject MS
* subject only Reference(SCDPatient)
* encounter MS
* encounter only Reference(SCDEncounter)
* performed[x] MS
* performer MS
* performer.actor MS
* performer.actor only Reference(SCDPractitioner or SCDPractitionerRole or SCDOrganization)
* reasonCode MS
* reasonReference MS
* reasonReference only Reference(SCDConditionEncounterDiagnosis or SCDConditionProblemsAndHealthConcerns)

// SCD-specific: link transfusion procedure to blood product(s) used
* usedReference MS
* usedReference ^short = "Medications or devices used during the procedure"
* usedReference ^comment = """
  FHIR R4 does not allow this element to reference BiologicallyDerivedProduct.
  For transfusions, link the blood product through the transfusion order
  instead (see the profile description).
"""
* usedReference only Reference (SCDMedication or Device )
// or SCDBiologicallyDerivedProduct

// SCD-specific: antigen matching used for the units transfused
* extension contains SCDTransfusionAntigenMatchExtension named scd-transfusion-antigen-match 0..1
* extension[scd-transfusion-antigen-match] ^short = "Red cell antigen matching used for the units transfused"

// ============================================================================== 
// SCDObservationLaboratoryResult
// ==============================================================================
// Extends: US Core Laboratory Result Observation Profile
// Purpose: Represents laboratory results relevant to SCD monitoring.
//
// Key SCD laboratory tests:
//   Hematology:
//     - CBC with differential: Hgb, Hct, MCV, WBC, ANC, platelets
//     - Reticulocyte count and percent
//   Hemoglobin Studies:
//     - Hemoglobin fractionation (HPLC/electrophoresis):
//       HbA %, HbS %, HbF %, HbA2 %, HbC %
//     - Newborn screening result
//   Hemolysis Markers:
//     - LDH (lactate dehydrogenase)
//     - Total and direct bilirubin
//     - Haptoglobin
//     - Peripheral blood smear (sickle cells, target cells, Howell-Jolly bodies)
//   Iron Status:
//     - Serum ferritin (iron overload monitoring)
//     - Serum iron, TIBC, transferrin saturation
//     - Liver iron concentration (MRI T2*/R2* — Observation not Imaging)
//   Renal / Hepatic:
//     - Serum creatinine, BUN, eGFR
//     - Urine albumin, urine albumin-to-creatinine ratio (UACR)
//     - AST, ALT, ALP (hepatic sequestration, iron chelation monitoring)
//   Cardiac / Pulmonary:
//     - NT-proBNP (pulmonary hypertension evaluation in symptomatic patients)
//     - Tricuspid regurgitant jet velocity (TRV) — by echo (if coded as Obs)
//   Transfusion / Immunohematology:
//     - ABO and Rh type
//     - Extended red cell antigen phenotype (Rh, Kell, Duffy, Kidd, MNS)
//     - Red cell antibody screen and identification (alloantibodies)
//     - Pre-transfusion crossmatch result
// ==============================================================================

// TODO: Cite a source for the HbSS steady-state hemoglobin range (about 6–9 g/dL)
//       and for ANC and platelet thresholds in hydroxyurea dose escalation
//       (for example, the NHLBI 2014 expert panel report), or remove them.
Profile: SCDObservationLaboratoryResult
Parent: us-core-observation-lab
Id: uscdi-scd-laboratory-result
Title: "USCDI-SCD Laboratory Result"
Description: """
  The USCDI-SCD Laboratory Result profile represents laboratory test results
  relevant to Sickle Cell Disease monitoring and management. This profile
  extends the [US Core Laboratory Result Observation Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-observation-lab.html).

  SCD requires extensive laboratory monitoring across multiple domains:

  **Complete Blood Count (CBC):** Hemoglobin (steady-state values in HbSS are
  typically about 6–9 g/dL and vary by patient and therapy), reticulocyte
  count, MCV, WBC, ANC, platelet count — monitored regularly and during acute
  events. ANC and platelet counts guide hydroxyurea dose escalation.

  **Hemoglobin Fractionation:** HPLC or electrophoresis measuring HbS%,
  HbF%, HbA%, HbA2%, HbC% — used for diagnosis confirmation, monitoring
  hydroxyurea response (rise in HbF), and pre/post-transfusion assessment.
  For children with HbSS or HbSβ0-thalassemia and a prior ischemic stroke, the
  [ASH 2020 cerebrovascular guideline](references.html#ash-2020-cerebrovascular) recommends
  keeping HbS below 30% until the next transfusion. The
  [NHLBI 2014 expert panel report](references.html#nhlbi-2014) lists
  uncomplicated painful crisis as an indication for which transfusion is not
  indicated.

  **Hemolysis Markers:** LDH, total/direct bilirubin, haptoglobin, reticulocyte
  count — elevated in SCD due to chronic hemolysis; useful for monitoring
  disease activity and response to therapy.

  **Iron Studies and Ferritin:** Used for patients on chronic transfusion
  therapy to detect and monitor transfusional iron overload. The
  [deferasirox (Exjade) labeling](references.html#label-deferasirox) calls for
  a serum ferritin consistently greater than 1,000 mcg/L, with transfusion of
  at least 100 mL/kg of packed red blood cells, before starting therapy. The
  [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) suggests MRI
  of liver iron content every 1 to 2 years rather than ferritin monitoring
  alone.

  **Renal Function:** Serum creatinine, eGFR, and urine albumin. The
  [NHLBI 2014 expert panel report](references.html#nhlbi-2014) recommends
  screening all individuals with SCD for proteinuria beginning by age 10, and
  repeating the screen annually if it is negative.

  **Immunohematology:** The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion)
  suggests an extended red cell antigen profile (at minimum C/c, E/e, K,
  Jka/Jkb, Fya/Fyb, M/N and S/s), by genotype or serology, for all patients
  with SCD at the earliest opportunity, optimally before the first
  transfusion; it prefers genotyping. Red cell antibody screening detects alloantibodies that may
  develop over time.

  Laboratory results use LOINC codes for `Observation.code`, as US Core requires
  (extensible binding). Results SHOULD include reference ranges where applicable.
"""

* ^status = #draft
* ^purpose = "Records laboratory results used to diagnose and monitor SCD, such as hemoglobin fractionation, for the SCD Diagnosis and SCD Emergency Care use cases."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Lab Result
* status MS
* category MS
* code MS
* code ^short = "LOINC code for SCD laboratory test"
* code ^comment = """
  SCD laboratory tests are coded using LOINC, as US Core requires. Common SCD
  LOINC codes:
  - Hemoglobin: 718-7
  - Hemoglobin S %: 4625-0
  - Hemoglobin F %: 4576-5
  - LDH: 14804-9
  - Ferritin: 2276-4
  - Serum creatinine: 2160-0
  - Urine albumin/creatinine ratio: 14959-1 or 9318-7
  - Reticulocyte count: 17849-1
  US Core requires LOINC codes here (extensible binding). The SCD Laboratory
  Panel value set lists tests commonly used in SCD care, for reference.
"""
// Non-constraining reference binding (purpose starter): adds no requirement beyond
// the US Core binding, which still applies.
* code ^binding.extension[+].url = "http://hl7.org/fhir/tools/StructureDefinition/additional-binding"
* code ^binding.extension[=].extension[+].url = "key"
* code ^binding.extension[=].extension[=].valueId = "scd-laboratory-reference"
* code ^binding.extension[=].extension[+].url = "purpose"
* code ^binding.extension[=].extension[=].valueCode = #starter
* code ^binding.extension[=].extension[+].url = "valueSet"
* code ^binding.extension[=].extension[=].valueCanonical = Canonical(SCDLaboratoryPanelVS)
* code ^binding.extension[=].extension[+].url = "documentation"
* code ^binding.extension[=].extension[=].valueMarkdown = "Reference list of laboratory tests commonly used in SCD care. It does not constrain exchange; the US Core binding applies. ONC maintains the SCD-relevant values for the USCDI+ Tests data element in USCDI+ ([SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) lists)."
* code ^binding.extension[=].extension[+].url = "shortDoco"
* code ^binding.extension[=].extension[=].valueString = "SCD reference list (USCDI+)"
* subject MS
* subject only Reference(SCDPatient)
* effective[x] MS
* value[x] MS
* dataAbsentReason MS
* interpretation MS
* specimen MS
* referenceRange MS
* referenceRange.low MS
* referenceRange.high MS

// Component for panel results (e.g., hemoglobin fractionation panel)
* component MS
* component ^short = "Individual result components (e.g., Hgb fractionation panel)"
* component.code MS
* component.value[x] MS

// ============================================================================== 
// SCDObservationVitalSigns
// ==============================================================================
// Extends: US Core Vital Signs Profile
// Purpose: Represents vital signs relevant to SCD monitoring.
//
// Key SCD vital signs:
//   - Oxygen saturation (SpO2): important for ACS diagnosis and monitoring;
//     mean baseline SpO2 is lower in SCD than in the general population
//   - Pain severity score: numeric rating scale (0-10) — primary measure
//     of VOC severity and treatment response
//   - Blood pressure: hypertension complicates renal disease; hypotension
//     may indicate sepsis or severe anemia
//   - Temperature: NHLBI 2014 calls for immediate evaluation at 38.5 C or higher
//   - Respiratory rate: elevated in ACS; used for sepsis screening
//   - Heart rate: tachycardia in anemia, infection, or pain
//   - Body weight: important for hydroxyurea and crizanlizumab dosing
// ==============================================================================

Profile: SCDObservationVitalSigns
Parent: us-core-vital-signs
Id: uscdi-scd-vital-signs
Title: "USCDI-SCD Vital Signs"
Description: """
  The USCDI-SCD Vital Signs profile represents vital sign measurements
  relevant to monitoring patients with Sickle Cell Disease. This profile
  extends the [US Core Vital Signs Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-vital-signs.html).

  Vital signs are particularly important in SCD for:

  **Oxygen Saturation (SpO2):**
  The [NHLBI 2014 expert panel report](references.html#nhlbi-2014) calls for
  pulse oximetry when evaluating a patient for acute chest syndrome (ACS),
  supplemental oxygen to keep SpO2 above 95% in ACS, and oxygen when SpO2 is
  below 95% on room air during a vaso-occlusive crisis.
  Systems that exchange vital signs are expected to include SpO2 when it is
  measured.
  LOINC: 2708-6 and 59408-5 (Oxygen saturation by pulse oximetry), as required
  by US Core.

  **Pain Severity Score:**
  Quantified pain intensity is the primary metric for VOC severity assessment
  and treatment titration. The Numeric Rating Scale (NRS, 0-10) is most
  commonly used. Pain scores SHOULD be recorded at each clinical assessment
  during an acute pain episode.
  LOINC: 38208-5 (Pain severity - Reported).

  **Temperature:**
  The NHLBI 2014 expert panel report calls for immediate evaluation of people
  with SCD who have a temperature of 38.5°C (101.3°F) or higher, because of the
  risk of severe bacterial infection.
  Temperature is expected to be recorded for ED and urgent care encounters.

  **Blood Pressure:**
  The [ASH 2019 cardiopulmonary and kidney guideline](references.html#ash-2019-cardiopulmonary-kidney)
  recommends a blood pressure goal below 130/80 mm Hg, over below 140/90 mm Hg,
  for adults with SCD (as amended by its [2023 correction](references.html#ash-2019-cardiopulmonary-kidney-correction)), and notes that baseline blood pressures are
  lower in the SCD population.

  **Respiratory Rate:**
  The NHLBI 2014 expert panel report lists tachypnea among the signs that
  should prompt evaluation for ACS.
"""

* ^status = #draft
* ^purpose = "Records vital signs relevant to SCD, such as oxygen saturation and temperature, for the SCD Emergency Care use case."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Vital Signs
* status MS
* category MS
* code MS
* code ^short = "Vital sign LOINC code (SpO2, pain score, BP, temp, RR, HR, weight)"
* subject MS
* subject only Reference(SCDPatient)
* effective[x] MS
* value[x] MS
* dataAbsentReason MS
* component MS
* component.code MS
* component.value[x] MS
* component.dataAbsentReason MS

// SpO2 and pain score are the vital signs most relevant to SCD monitoring
* code ^comment = """
  Vital signs most relevant to SCD:
  - SpO2: LOINC 2708-6 and 59408-5 (ACS detection)
  - Pain score (NRS 0-10): LOINC 38208-5 (VOC assessment)
  - Body temperature: LOINC 8310-5
  - Blood pressure: LOINC 85354-9 (panel), 8480-6 (systolic), 8462-4 (diastolic)
  - Heart rate: LOINC 8867-4
  - Respiratory rate: LOINC 9279-1
  - Body weight: LOINC 29463-7
  US Core's vital signs binding applies. The SCD Vital Signs value set lists
  vital signs especially relevant to SCD, for reference.
"""


// ==============================================================================
// SCDBiologicallyDerivedProduct
// ==============================================================================
// Base: FHIR R4 BiologicallyDerivedProduct (NO US Core parent profile)
// Purpose: Represents blood products used in SCD care, primarily:
//   - Packed red blood cells (pRBCs) — simple or exchange transfusion
//   - Hematopoietic progenitor cells (HPC) — for HSCT
//
// FHIR 4.0.1 BiologicallyDerivedProduct maturity: Trial Use (FMM 0)
// Note: FHIR R5 significantly enhanced this resource. This profile is
//       constrained to the capabilities of FHIR R4.0.1.
//
// Key elements for SCD:
//   - productCode: ISBT 128 or SNOMED CT product type code
//   - collection.source: donor or autologous
//   - processing: leukoreduction, irradiation (when indicated), antigen-negative
//     unit selection, HbS-negative units
//   - storage: ABO/Rh-compatible, antigen-matched unit
//   - request: links back to the ServiceRequest (transfusion order)
// ==============================================================================

// TODO: Cite a source for chronic transfusion to prevent recurrent acute chest
//       syndrome when hydroxyurea is not effective, then restore it below.
Profile: SCDBiologicallyDerivedProduct
Parent: BiologicallyDerivedProduct
Id: uscdi-scd-biologicallyderivedproduct
Title: "USCDI-SCD BiologicallyDerivedProduct"
Description: """
  The USCDI-SCD BiologicallyDerivedProduct profile represents a blood product
  or other biologically derived product used in the care of patients with
  Sickle Cell Disease. This profile is based directly on the
  [FHIR R4 BiologicallyDerivedProduct resource](http://hl7.org/fhir/R4/biologicallyderivedproduct.html)
  as there is no US Core parent profile for this resource.

  **Role in SCD Care:**

  Red cell transfusion remains a mainstay of SCD therapy
  ([ASH 2020 transfusion guideline](references.html#ash-2020-transfusion)). Blood products
  are used for:
  - **Acute transfusion:** Rapid correction of severe anemia (aplastic crisis,
    splenic sequestration), preparation for surgery, or stroke treatment
  - **Chronic transfusion therapy:** Regular simple or exchange transfusions
    for primary and secondary stroke prevention ([NHLBI 2014 expert panel report](references.html#nhlbi-2014);
    [ASH 2020 cerebrovascular guideline](references.html#ash-2020-cerebrovascular)).
    Transfusion is not indicated for uncomplicated vaso-occlusive crisis.
  - **Automated red cell exchange (erythrocytapheresis):** Replaces patient
    red cells with donor cells. The ASH 2020 transfusion guideline suggests
    automated exchange over simple transfusion or manual exchange for chronic
    transfusion, mainly because it was associated with less iron overload
  - **Hematopoietic stem cell transplantation (HSCT):** Allogeneic hematopoietic
    progenitor cell products (HPC-A or HPC-M) used in curative HSCT

  **Antigen Matching:**

  The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) reports
  that red cell alloimmunization incidence in SCD is the highest of any
  transfused patient population. RH genetic diversity is one risk factor: most
  patients with SCD have at least one RH allele that differs from those found
  in people of European descent. The guideline recommends prophylactic
  matching for Rh (C, E or C/c, E/e) and K antigens, and notes that extended
  matching (Jka/Jkb, Fya/Fyb, S/s) may provide further protection. This profile supports documentation of
  antigen matching via extension or the processing element.

  **Product Coding:**

  In this version, blood product types are coded with SNOMED CT (see the SCD
  Blood Product Type value set, example binding). ISBT 128, the international
  standard for blood product labeling, MAY be sent as an additional coding.
  Requirements for ISBT 128 coding are planned for a future version, once the
  FHIR code system URI for ISBT 128 is confirmed.

  **Limitations in FHIR R4:**

  The FHIR R4 BiologicallyDerivedProduct resource has limited granularity
  compared to FHIR R5. This profile records antigen matching and product age
  with extensions, and irradiation, leukoreduction and other processing steps
  with codes in processing.procedure. See [Extensions](extensions.html).
"""

* ^status = #draft
* ^purpose = "Records blood products transfused to a person with SCD, including antigen matching and processing, for the SCD Emergency Care use case."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// SCD-specific extensions
* extension contains
    SCDTransfusionAntigenMatchExtension named scd-transfusion-antigen-match 0..1 MS and
    SCDBloodProductAgeExtension named scd-blood-product-age 0..1 MS
* extension[scd-transfusion-antigen-match] ^short = "Red cell antigens matched for this product"
* extension[scd-blood-product-age] ^short = "Age of the product in days at transfusion"

// Product identification
* productCode MS
* productCode ^short = "Blood product type code (SNOMED CT; ISBT 128 planned for a future version)"
// TODO: add codes for hematopoietic progenitor cells from bone marrow and cord
//       blood (no SNOMED CT product concepts exist; consider ISBT 128).
* productCode ^comment = """
  Use SNOMED CT product codes. ISBT 128 product codes MAY be included as an
  additional coding; ISBT 128 requirements are planned for a future version.

  Common SCD blood product codes (SNOMED CT):
  - 431069006 — Packed red blood cells
  - 126251004 — Leukocyte reduced red blood cells, human
  - 126256009 — Red blood cells, human, irradiated
  - 1351653002 — Stem cells, apheresis

  The SCD Blood Product Type value set lists common products (example binding).
"""
* productCode from SCDBloodProductTypeVS (example)

// Status of the product
* status MS
* status ^short = "available | unavailable"

// Product category
* productCategory MS
* productCategory ^short = "biologicalAgent | cells | fluid | tissue | organ"
* productCategory ^comment = """
  For red blood cell products: #cells
  For HPC products: #cells
"""

// Request linkage — back to the transfusion ServiceRequest
* request MS
* request ^short = "Reference to the transfusion order (SCDServiceRequest)"
* request only Reference(SCDServiceRequest)

// Collection information
* collection MS
* collection ^short = "Collection details (donor vs autologous, collection time)"
* collection.source MS
* collection.source ^short = "Donor (allogeneic) or patient (autologous)"
* collection.collected[x] MS

// Processing (irradiation, leukoreduction, antigen matching)
* processing MS
* processing ^short = "Product processing steps (irradiation, leukoreduction, CMV-neg)"
// TODO: Cite a transfusion guideline for irradiation indications.
* processing ^comment = """
  Document processing modifiers applied to the blood product. SCD-specific
  processing considerations:
  - Leukoreduction: The NHLBI 2014 expert panel report notes that most red
    cell units given to people with SCD in the United States are leukoreduced;
    benefits documented in other populations include fewer febrile
    non-hemolytic reactions, less CMV transmission and less HLA alloimmunization
  - Irradiation: Indicated for specific patient groups per transfusion
    guidelines and institutional policy
  - CMV-seronegative units: An institutional choice for selected patients
  - Antigen-negative units: Rh (C, E or C/c, E/e) and K at minimum (ASH 2020
    transfusion guideline); extended matching (Jk, Fy, S) per institutional
    protocol — document matched
    antigens in the processing description or via extension

  processing.procedure has an example binding to the SCD Blood Product
  Processing value set.
"""
* processing.description MS
* processing.procedure MS
* processing.procedure from SCDBloodProductProcessingVS (example)
* processing.time[x] MS

// Storage
* storage MS
* storage ^short = "Storage conditions and duration"
* storage.duration MS

// SCD-specific blood product attributes: antigen matching and product age use the
// scd-transfusion-antigen-match and scd-blood-product-age extensions (above);
// leukoreduction, irradiation and CMV-negative selection are processing codes
// in the SCD Blood Product Processing code system.
