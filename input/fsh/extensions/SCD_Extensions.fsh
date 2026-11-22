// ==============================================================================
// USCDI-SCD FSH Extensions
// File: input/fsh/extensions/SCD_Extensions.fsh
//
// Extensions defined by the USCDI-SCD IG for SCD-specific data elements
// not covered by base FHIR R4 or US Core 8.0.1.
//
// Each extension includes:
//   - Clinical rationale
//   - Context of use (which resource/element it extends)
//   - Data type and value constraints
//
// DESIGN PRINCIPLE: Extensions are defined sparingly. Before creating a new
// extension, the IG authors SHALL verify that:
//   1. The concept cannot be represented using existing FHIR elements
//   2. No suitable extension exists in hl7.fhir.uv.extensions.r4
//   3. The US Core 8.0.1 package does not already provide the extension
// ==============================================================================


// ==============================================================================
// Extension: Transfusion Red Cell Antigen Match
// ==============================================================================
// Context: BiologicallyDerivedProduct (SCDBiologicallyDerivedProduct)
//          Procedure (SCDProcedure — transfusion)
// Purpose: Documents the red cell antigen matching criteria applied to a
//          specific blood product or transfusion order, supporting extended
//          antigen-matched transfusion therapy in SCD.
// ==============================================================================

Extension: SCDTransfusionAntigenMatchExtension
Id: scd-transfusion-antigen-match
Title: "SCD Transfusion Red Cell Antigen Match"
Description: """
  Documents the red cell antigen matching criteria that were applied in
  selecting a blood product for transfusion in a patient with Sickle Cell Disease.

  The [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) recommends
  prophylactic red cell antigen matching for Rh (C, E or C/c, E/e) and K
  antigens, over ABO/RhD matching alone, for patients with SCD receiving
  transfusions. It notes that extended matching (Jka/Jkb, Fya/Fyb, S/s) may
  provide further protection from alloimmunization. This extension enables structured documentation of
  which antigens were matched for a given transfusion event.

  This extension is used on the USCDI-SCD BiologicallyDerivedProduct to record
  the antigens matched. It may also be used on the USCDI-SCD Procedure for the
  transfusion, to record the antigen matching used for the units transfused.
"""
* ^status = #draft
* ^purpose = "Records which red cell antigens a transfused unit was matched for, because FHIR R4 BiologicallyDerivedProduct and Procedure have no element for it."
* ^experimental = false
* ^context[+].type = #element
* ^context[=].expression = "BiologicallyDerivedProduct"
* ^context[+].type = #element
* ^context[=].expression = "Procedure"

* extension contains
    matchedAntigen 0..* MS and
    matchingProtocol 0..1 MS

* extension[matchedAntigen] ^short = "Specific antigen confirmed matched/negative"
* extension[matchedAntigen] ^definition = "A specific red cell antigen that was confirmed negative (matched) in the selected blood product."
* extension[matchedAntigen].value[x] only CodeableConcept
* extension[matchedAntigen].valueCodeableConcept from SCDRedCellAntigenVS (example)

* extension[matchingProtocol] ^short = "Antigen matching protocol used"
* extension[matchingProtocol] ^definition = "The institutional or standard matching protocol applied (e.g., 'CcEeK matching', 'Extended 5-antigen match', 'Full phenotype match')."
* extension[matchingProtocol].value[x] only string


// ==============================================================================
// Extension: SCD Hydroxyurea Adherence
// ==============================================================================
// Context: MedicationStatement or Observation
// Purpose: Captures structured adherence data for hydroxyurea therapy.
// ==============================================================================

Extension: SCDHydroxyureaAdherenceExtension
Id: scd-hydroxyurea-adherence
Title: "SCD Hydroxyurea Adherence"
Description: """
  Captures the documented level of adherence of a patient to hydroxyurea
  therapy, and how and when it was assessed (for example by patient or caregiver
  report, pharmacy refill records or pill count).

  This extension is intended for use on MedicationStatement or Observation. No
  profile in this guide uses it yet. Whether to replace it with the US Core
  Medication Adherence extension, which applies to MedicationRequest, is an
  open question.
"""
* ^status = #draft
* ^purpose = "Records adherence to hydroxyurea therapy. No profile in this guide uses it yet; whether to replace it with the US Core Medication Adherence extension is open question OQ-28."
* ^experimental = false
* ^context[+].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "Observation"

* extension contains
    adherenceLevel 0..1 MS and
    adherenceMethod 0..1 MS and
    assessmentDate 0..1 MS

* extension[adherenceLevel] ^short = "Adherence level (high / moderate / low / non-adherent)"
* extension[adherenceLevel].value[x] only CodeableConcept
// TODO: Bind to adherence level VS (locally defined or SNOMED CT)

* extension[adherenceMethod] ^short = "Method used to assess adherence"
* extension[adherenceMethod].value[x] only CodeableConcept
// TODO: Bind to adherence method VS

* extension[assessmentDate] ^short = "Date adherence was assessed"
* extension[assessmentDate].value[x] only date


// ==============================================================================
// Extension: SCD VOC Episode Frequency
// ==============================================================================
// Context: Condition (SCDConditionProblemsAndHealthConcerns)
// Purpose: Documents the frequency of vaso-occlusive crisis (VOC) episodes
//          over a defined period, a key clinical indicator used to guide
//          therapy decisions (e.g., starting hydroxyurea or crizanlizumab,
//          considering HSCT).
// ==============================================================================

Extension: SCDVOCFrequencyExtension
Id: scd-voc-frequency
Title: "SCD Vaso-Occlusive Crisis Frequency"
Description: """
  Documents the reported or documented frequency of vaso-occlusive crisis (VOC)
  episodes for a patient with Sickle Cell Disease over a defined observation
  period. This is a key clinical parameter used to assess disease severity
  and guide therapy escalation.

  Clinical context:
  - [NHLBI 2014 expert panel report](references.html#nhlbi-2014): adults with sickle cell anemia who have 3 or more moderate to
    severe pain crises in 12 months should be treated with hydroxyurea.
    (Infants from 9 months, children and adolescents with HbSS or HbS-Beta0
    should be offered hydroxyurea regardless of clinical severity.)
  - Crizanlizumab is indicated to reduce the frequency of VOCs in adults and
    pediatric patients aged 16 years and older with SCD; the indication does
    not specify a minimum VOC count ([ADAKVEO labeling](references.html#label-crizanlizumab)).
  - The [ASH 2021 stem cell transplantation guideline](references.html#ash-2021-hsct)
    conditionally suggests matched related allogeneic transplantation, rather
    than standard care, for patients with frequent pain.

  This extension is intended for use on the Condition resource representing
  the patient's primary SCD diagnosis (problem list entry).
"""
* ^status = #draft
* ^purpose = "Records how often vaso-occlusive crisis episodes occur over a period, because Condition has no element for an episode count."
* ^experimental = false
* ^context[+].type = #element
* ^context[=].expression = "Condition"

* extension contains
    episodeCount 1..1 MS and
    observationPeriod 1..1 MS and
    measurementMethod 0..1 MS

* extension[episodeCount] ^short = "Number of VOC episodes in the observation period"
* extension[episodeCount].value[x] only integer

* extension[observationPeriod] ^short = "Period over which VOC episodes were counted"
* extension[observationPeriod].value[x] only Period

* extension[measurementMethod] ^short = "How episodes were counted (self-report, chart review, hospitalization records)"
* extension[measurementMethod].value[x] only CodeableConcept


// ==============================================================================
// Extension: SCD Blood Product Age
// ==============================================================================
// Context: BiologicallyDerivedProduct (SCDBiologicallyDerivedProduct)
// Purpose: Documents the age of a blood product (days from collection to
//          transfusion) at the time of transfusion.
// TODO: Cite a source for institutional storage-age preferences (for example,
//       7 to 14 days) for SCD exchange transfusion, then restore them below.
// ==============================================================================

Extension: SCDBloodProductAgeExtension
Id: scd-blood-product-age
Title: "SCD Blood Product Age at Transfusion"
Description: """
  Documents the age of a blood product in days from the date of collection
  (phlebotomy) to the date of transfusion. Neither the
  [NHLBI 2014 expert panel report](references.html#nhlbi-2014) nor the
  [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion)
  makes a recommendation on red cell storage age.

  This extension is intended for use on SCDBiologicallyDerivedProduct instances
  when the product age at time of transfusion is clinically documented.
"""
* ^status = #draft
* ^purpose = "Records the age of a blood product at transfusion, because FHIR R4 BiologicallyDerivedProduct has no element for it."
* ^experimental = false
* ^context[+].type = #element
* ^context[=].expression = "BiologicallyDerivedProduct"

* value[x] only Quantity
* valueQuantity.system = "http://unitsofmeasure.org"
* valueQuantity.code = #d
* valueQuantity ^short = "Age of blood product in days at time of transfusion"


// ==============================================================================
// Extension: SCD Iron Chelation Indication
// ==============================================================================
// Context: MedicationRequest (iron chelation prescriptions)
// Purpose: Documents the clinical indication and triggering threshold for
//          initiating iron chelation therapy in an SCD patient, supporting
//          quality measurement and care documentation.
// ==============================================================================

Extension: SCDIronChelationIndicationExtension
Id: scd-iron-chelation-indication
Title: "SCD Iron Chelation Indication"
Description: """
  Documents the clinical indication and triggering laboratory or imaging
  threshold that led to initiation of iron chelation therapy for a patient
  with Sickle Cell Disease on chronic transfusion therapy.

  The [deferasirox (Exjade) labeling](references.html#label-deferasirox) calls
  for evidence of chronic transfusional iron overload before starting therapy,
  including transfusion of at least 100 mL/kg of packed red blood cells and a
  serum ferritin consistently greater than 1,000 mcg/L. The
  [ASH 2020 transfusion guideline](references.html#ash-2020-transfusion) suggests MRI
  screening of liver iron content every 1 to 2 years, rather than serial
  ferritin monitoring alone, for patients on chronic transfusion. This
  extension captures the specific trigger value and the method used to assess
  iron burden.
"""
* ^status = #draft
* ^purpose = "Records the reason iron chelation was started and the measurement and value that triggered it (for example a serum ferritin level), which MedicationRequest.reasonCode alone does not carry."
* ^experimental = false
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"

* extension contains
    indicationCode 0..1 MS and
    triggerMeasurement 0..1 MS and
    triggerValue 0..1 MS

* extension[indicationCode] ^short = "Reason for initiating iron chelation"
* extension[indicationCode].value[x] only CodeableConcept
// TODO: Bind to iron overload indication value set

* extension[triggerMeasurement] ^short = "Laboratory or imaging measure that triggered chelation"
* extension[triggerMeasurement].value[x] only CodeableConcept
// e.g., serum ferritin, liver iron concentration (MRI), transferrin saturation

* extension[triggerValue] ^short = "The value at which chelation was initiated"
* extension[triggerValue].value[x] only Quantity


// ==============================================================================
// Extension: SCD Newborn Screen Reference
// ==============================================================================
// Context: Condition (primary SCD diagnosis)
//          Patient (SCDPatient)
// Purpose: Links the SCD diagnosis on the problem list to the original
//          newborn screening result that established the diagnosis, supporting
//          continuity of newborn screening follow-up programs and state registry
//          integration.
// ==============================================================================

Extension: SCDNewbornScreenReferenceExtension
Id: scd-newborn-screen-reference
Title: "SCD Newborn Screen Reference"
Description: """
  References the Observation or DiagnosticReport representing the newborn
  screening result that originally identified or confirmed the patient's
  Sickle Cell Disease diagnosis. This extension supports longitudinal care
  coordination between state newborn screening programs, follow-up programs
  (such as HRSA-funded SCD newborn screening follow-up programs), and ongoing
  clinical care.

  The referenced resource SHOULD be an Observation (hemoglobin fractionation
  result from newborn heel stick) or a DiagnosticReport representing the
  complete newborn screen report.
"""
* ^status = #draft
* ^purpose = "Links a person's SCD record to the newborn screening result that first identified SCD."
* ^experimental = false
* ^context[+].type = #element
* ^context[=].expression = "Condition"
* ^context[+].type = #element
* ^context[=].expression = "Patient"

* value[x] only Reference(Observation or DiagnosticReport)
* valueReference ^short = "Reference to the original newborn screening Observation or DiagnosticReport"
