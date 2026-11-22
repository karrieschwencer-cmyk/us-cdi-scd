// ==============================================================================
// USCDI-SCD FSH Value Sets
// File: input/fsh/valuesets/SCD_ValueSets.fsh
//
// Value sets defined in this file:
//   - SCDDiagnosisVS
//   - SCDAcuteComplicationVS
//   - SCDMedicationVS
//   - SCDLaboratoryPanelVS
//   - SCDProcedureVS
//   - SCDBloodProductTypeVS
//   - SCDVitalSignsVS
//   - SCDBloodProductProcessingVS
//   - SCDRedCellAntigenVS
//
// NOTE: VSAC-hosted value sets (OID-referenced) should be defined in VSAC
//       and referenced here by canonical URI. Value sets listed here are
//       defined locally for IG completeness pending VSAC submission.
// ==============================================================================


// ==============================================================================
// SCDDiagnosisVS — Primary SCD Diagnosis Codes
// ==============================================================================
// Covers the root SCD diagnosis codes (ICD-10-CM and SNOMED CT).
// This VS is intended for binding to SCDConditionProblemsAndHealthConcerns.code
// for the primary SCD diagnosis entry on the problem list.
// ==============================================================================

// TODO: Expand with complete SNOMED CT concept set and confirm ICD-10-CM code
//       coverage.
ValueSet: SCDDiagnosisVS
Id: scd-diagnosis-vs
Title: "SCD Diagnosis Value Set"
Description: """
  Value set of codes representing the primary Sickle Cell Disease diagnoses,
  including all major genotypic subtypes, with and without crisis. Linked as a
  reference list to `Condition.code` in both USCDI-SCD Condition profiles.

  Includes ICD-10-CM D57.x codes and equivalent SNOMED CT codes, and the SNOMED
  CT concepts for suspected sickle cell disease and family history of sickle
  cell anemia. Sickle cell trait is not included.
"""
* ^status = #draft
* ^purpose = "Reference list of SCD diagnosis codes, covering each SCD subtype, for identifying people with SCD. It adds no conformance requirement beyond US Core."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"
* ^copyright = "ICD-10 is copyrighted by the World Health Organization (WHO), which owns and publishes the classification (see https://www.who.int/classifications/icd/en). WHO has authorized the development of an adaptation of ICD-10 to ICD-10-CM for use in the United States for U.S. government purposes. This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."

// ICD-10-CM — Sickle Cell Disease codes (D57 category)
// HbSS and unspecified sickle cell disease without crisis (other genotypes have
// their own without-crisis codes, listed below)
* $icd10cm#D57.1   "Sickle-cell disease without crisis"
// HbSS (Sickle Cell Anemia)
* $icd10cm#D57.00  "Hb-SS disease with crisis, unspecified"
* $icd10cm#D57.01  "Hb-SS disease with acute chest syndrome"
* $icd10cm#D57.02  "Hb-SS disease with splenic sequestration"
* $icd10cm#D57.03  "Hb-SS disease with cerebral vascular involvement"
* $icd10cm#D57.04  "Hb-SS disease with dactylitis"
* $icd10cm#D57.09  "Hb-SS disease with crisis with other specified complication"
// HbSC
* $icd10cm#D57.20  "Sickle-cell/Hb-C disease without crisis"
* $icd10cm#D57.211 "Sickle-cell/Hb-C disease with acute chest syndrome"
* $icd10cm#D57.212 "Sickle-cell/Hb-C disease with splenic sequestration"
* $icd10cm#D57.213 "Sickle-cell/Hb-C disease with cerebral vascular involvement"
* $icd10cm#D57.214 "Sickle-cell/Hb-C disease with dactylitis"
* $icd10cm#D57.218 "Sickle-cell/Hb-C disease with crisis with other specified complication"
* $icd10cm#D57.219 "Sickle-cell/Hb-C disease with crisis, unspecified"
// HbS-Beta-thalassemia
* $icd10cm#D57.40  "Sickle-cell thalassemia without crisis"
* $icd10cm#D57.411 "Sickle-cell thalassemia, unspecified, with acute chest syndrome"
* $icd10cm#D57.412 "Sickle-cell thalassemia, unspecified, with splenic sequestration"
* $icd10cm#D57.413 "Sickle-cell thalassemia, unspecified, with cerebral vascular involvement"
* $icd10cm#D57.414 "Sickle-cell thalassemia, unspecified, with dactylitis"
* $icd10cm#D57.418 "Sickle-cell thalassemia, unspecified, with crisis with other specified complication"
* $icd10cm#D57.419 "Sickle-cell thalassemia, unspecified, with crisis"
* $icd10cm#D57.42  "Sickle-cell thalassemia beta zero without crisis"
* $icd10cm#D57.431 "Sickle-cell thalassemia beta zero with acute chest syndrome"
* $icd10cm#D57.432 "Sickle-cell thalassemia beta zero with splenic sequestration"
* $icd10cm#D57.433 "Sickle-cell thalassemia beta zero with cerebral vascular involvement"
* $icd10cm#D57.434 "Sickle-cell thalassemia beta zero with dactylitis"
* $icd10cm#D57.438 "Sickle-cell thalassemia beta zero with crisis with other specified complication"
* $icd10cm#D57.439 "Sickle-cell thalassemia beta zero with crisis, unspecified"
* $icd10cm#D57.44  "Sickle-cell thalassemia beta plus without crisis"
* $icd10cm#D57.451 "Sickle-cell thalassemia beta plus with acute chest syndrome"
* $icd10cm#D57.452 "Sickle-cell thalassemia beta plus with splenic sequestration"
* $icd10cm#D57.453 "Sickle-cell thalassemia beta plus with cerebral vascular involvement"
* $icd10cm#D57.454 "Sickle-cell thalassemia beta plus with dactylitis"
* $icd10cm#D57.458 "Sickle-cell thalassemia beta plus with crisis with other specified complication"
* $icd10cm#D57.459 "Sickle-cell thalassemia beta plus with crisis, unspecified"
// Other and unspecified SCD
* $icd10cm#D57.80  "Other sickle-cell disorders without crisis"
* $icd10cm#D57.811 "Other sickle-cell disorders with acute chest syndrome"
* $icd10cm#D57.812 "Other sickle-cell disorders with splenic sequestration"
* $icd10cm#D57.813 "Other sickle-cell disorders with cerebral vascular involvement"
* $icd10cm#D57.814 "Other sickle-cell disorders with dactylitis"
* $icd10cm#D57.818 "Other sickle-cell disorders with crisis with other specified complication"
* $icd10cm#D57.819 "Other sickle-cell disorders with crisis, unspecified"

// SNOMED CT — Sickle Cell Disease concepts
* $sct#127040003  "Sickle cell-hemoglobin SS disease"
* $sct#35434009  "Sickle cell-hemoglobin C disease"
* $sct#127043001  "Sickle cell-beta^0^-thalassemia"
* $sct#127042006  "Sickle cell beta plus thalassemia"
* $sct#25472008  "Sickle cell-hemoglobin D disease"
* $sct#47024008  "Sickle cell-hemoglobin E disease"
* $sct#127048005  "Sickle cell-Hemoglobin O Arab disease"
* $sct#417357006   "Sickling disorder due to hemoglobin S"   // parent concept
// Checked with $subsumes on tx.fhir.org (SNOMED CT International 20260701):
// 417357006 does not subsume 16402000 Sickle cell trait.

// Added from the USCDI+ SCD value set workbook review (2026-11-22); verified on tx.fhir.org
* $sct#127041004  "Sickle cell-beta-thalassemia"
* $sct#127044007  "Sickle cell-delta beta^0^-thalassemia"
* $sct#127045008  "Sickle cell anemia with coexistent alpha-thalassemia"
* $sct#127047000  "Sickle cell-hemoglobin Lepore disease"
* $sct#23269001  "Double heterozygous sickling disorder"
* $sct#234391009  "Sickle cell anemia with high hemoglobin F"
* $sct#36472007  "Sickle cell-thalassemia disease"
* $sct#416180004  "Hemoglobin SS disease without crisis"
* $sct#416214006  "Sickle cell-hemoglobin D disease without crisis"
* $sct#416290001  "Hemoglobin S sickling disorder without crisis"
* $sct#416484003  "Sickle cell-hemoglobin E disease with crisis"
* $sct#416638004  "Sickle cell-hemoglobin E disease without crisis"
* $sct#416826005  "Sickle cell-thalassemia disease with crisis"
* $sct#417048006  "Sickle cell-thalassemia disease without crisis"
* $sct#417279003  "Hemoglobin S sickling disorder with crisis"
* $sct#417425009  "Hemoglobin SS disease with crisis"
* $sct#417517009  "Sickle cell-hemoglobin C disease with crisis"
* $sct#417683006  "Sickle cell-hemoglobin C disease without crisis"
* $sct#417748003  "Sickle cell-hemoglobin D disease with crisis"
* $sct#440206000  "Hemoglobin SS disease with vasoocclusive crisis"
* $sct#473131004  "Sickle cell disease suspected"
* $sct#160320002  "Family history of sickle cell anemia"
* $sct#783254003  "Hereditary persistence of fetal hemoglobin with sickle cell disease syndrome"


// ==============================================================================
// SCDAcuteComplicationVS — Acute SCD Complication Diagnosis Codes
// ==============================================================================
// Reference list for Condition.code in both USCDI-SCD Condition profiles
// ==============================================================================

// TODO: Expand SNOMED CT concept coverage.
ValueSet: SCDAcuteComplicationVS
Id: scd-acute-complication-vs
Title: "SCD Acute Complication Value Set"
Description: """
  Value set of codes representing acute complications of Sickle Cell Disease
  that may be documented as encounter diagnoses. Includes every ICD-10-CM D57
  "with crisis" code, and SNOMED CT codes for vaso-occlusive crisis, acute chest
  syndrome, splenic sequestration, priapism, dactylitis, stroke (ischemic and
  hemorrhagic), aplastic crisis, sepsis, acute kidney injury, osteomyelitis and
  delayed hemolytic transfusion reaction. The stroke, sepsis, acute kidney
  injury, osteomyelitis and transfusion reaction codes are general codes, not
  specific to SCD.
"""
* ^status = #draft
* ^purpose = "Reference list of codes for acute SCD complications documented as encounter diagnoses. It adds no conformance requirement beyond US Core."
* ^copyright = "ICD-10 is copyrighted by the World Health Organization (WHO), which owns and publishes the classification (see https://www.who.int/classifications/icd/en). WHO has authorized the development of an adaptation of ICD-10 to ICD-10-CM for use in the United States for U.S. government purposes. This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// ICD-10-CM — every billable D57 "with crisis" code, for each SCD genotype
// (the same codes are also in SCDDiagnosisVS). D57.09 is listed under aplastic crisis below.
* $icd10cm#D57.00  "Hb-SS disease with crisis, unspecified"
* $icd10cm#D57.01  "Hb-SS disease with acute chest syndrome"
* $icd10cm#D57.02  "Hb-SS disease with splenic sequestration"
* $icd10cm#D57.03  "Hb-SS disease with cerebral vascular involvement"
* $icd10cm#D57.04  "Hb-SS disease with dactylitis"
* $icd10cm#D57.211 "Sickle-cell/Hb-C disease with acute chest syndrome"
* $icd10cm#D57.212 "Sickle-cell/Hb-C disease with splenic sequestration"
* $icd10cm#D57.213 "Sickle-cell/Hb-C disease with cerebral vascular involvement"
* $icd10cm#D57.214 "Sickle-cell/Hb-C disease with dactylitis"
* $icd10cm#D57.218 "Sickle-cell/Hb-C disease with crisis with other specified complication"
* $icd10cm#D57.219 "Sickle-cell/Hb-C disease with crisis, unspecified"
* $icd10cm#D57.411 "Sickle-cell thalassemia, unspecified, with acute chest syndrome"
* $icd10cm#D57.412 "Sickle-cell thalassemia, unspecified, with splenic sequestration"
* $icd10cm#D57.413 "Sickle-cell thalassemia, unspecified, with cerebral vascular involvement"
* $icd10cm#D57.414 "Sickle-cell thalassemia, unspecified, with dactylitis"
* $icd10cm#D57.418 "Sickle-cell thalassemia, unspecified, with crisis with other specified complication"
* $icd10cm#D57.419 "Sickle-cell thalassemia, unspecified, with crisis"
* $icd10cm#D57.431 "Sickle-cell thalassemia beta zero with acute chest syndrome"
* $icd10cm#D57.432 "Sickle-cell thalassemia beta zero with splenic sequestration"
* $icd10cm#D57.433 "Sickle-cell thalassemia beta zero with cerebral vascular involvement"
* $icd10cm#D57.434 "Sickle-cell thalassemia beta zero with dactylitis"
* $icd10cm#D57.438 "Sickle-cell thalassemia beta zero with crisis with other specified complication"
* $icd10cm#D57.439 "Sickle-cell thalassemia beta zero with crisis, unspecified"
* $icd10cm#D57.451 "Sickle-cell thalassemia beta plus with acute chest syndrome"
* $icd10cm#D57.452 "Sickle-cell thalassemia beta plus with splenic sequestration"
* $icd10cm#D57.453 "Sickle-cell thalassemia beta plus with cerebral vascular involvement"
* $icd10cm#D57.454 "Sickle-cell thalassemia beta plus with dactylitis"
* $icd10cm#D57.458 "Sickle-cell thalassemia beta plus with crisis with other specified complication"
* $icd10cm#D57.459 "Sickle-cell thalassemia beta plus with crisis, unspecified"
* $icd10cm#D57.811 "Other sickle-cell disorders with acute chest syndrome"
* $icd10cm#D57.812 "Other sickle-cell disorders with splenic sequestration"
* $icd10cm#D57.813 "Other sickle-cell disorders with cerebral vascular involvement"
* $icd10cm#D57.814 "Other sickle-cell disorders with dactylitis"
* $icd10cm#D57.818 "Other sickle-cell disorders with crisis with other specified complication"
* $icd10cm#D57.819 "Other sickle-cell disorders with crisis, unspecified"

// SNOMED CT — Acute SCD complications
* $sct#769167005   "Vaso-occlusive pain episode in sickle cell disease"
* $sct#372146004   "Acute chest syndrome"
* $sct#444108000  "Acute sickle cell splenic sequestration crisis"
* $sct#367061000119107  "Priapism due to sickle cell disease"
* $sct#371104006  "Hand-foot syndrome in sickle cell anemia"
// Avascular necrosis is a chronic complication and is not included here.
// The project has chosen not to define additional value sets that would
// constrain the exchanged data. Value sets for chronic complications may be
// considered later (for example, to prioritize display in the Emergency
// Department use case, or for future registry and research phases).

// Stroke / Cerebrovascular
* $icd10cm#I63.9  "Cerebral infarction, unspecified"
* $sct#230690007  "Cerebrovascular accident"

// Aplastic crisis (D57.09 applies to HbSS only; other genotypes use their
// "other specified complication" codes, such as D57.218)
* $sct#69075005   "Aplastic crisis"
* $icd10cm#D57.09 "Hb-SS disease with crisis with other specified complication"

// Fever and sepsis (general codes, included because infection is an acute SCD complication)
* $icd10cm#A41.9  "Sepsis, unspecified organism"
* $sct#91302008   "Sepsis"

// Other acute complications (added after clinical review)
* $icd10cm#N48.32  "Priapism due to disease classified elsewhere"   // priapism, with the D57 code for the SCD type
* $sct#274100004  "Cerebral hemorrhage"   // hemorrhagic stroke
* $icd10cm#I61.9  "Nontraumatic intracerebral hemorrhage, unspecified"   // hemorrhagic stroke
* $sct#83250000  "Delayed hemolytic transfusion reaction"   // delayed hemolytic transfusion reaction
* $icd10cm#T80.A11A  "Non-ABO incompatibility with delayed hemolytic transfusion reaction, initial encounter"   // delayed hemolytic transfusion reaction (non-ABO)
* $sct#14669001  "Acute kidney injury"   // acute kidney injury
* $icd10cm#N17.9  "Acute kidney failure, unspecified"   // acute kidney injury
* $sct#60168000  "Osteomyelitis"   // osteomyelitis
* $icd10cm#M86.9  "Osteomyelitis, unspecified"   // osteomyelitis
// No SNOMED CT or ICD-10-CM concept was found for hyperhemolysis or hepatic sequestration;
// they are not listed. TODO: terminologist to confirm.


// ==============================================================================
// SCDMedicationVS — SCD Disease-Related Medications
// ==============================================================================
// For use with SCDMedication.code (RxNorm)
// ==============================================================================

ValueSet: SCDMedicationVS
Id: scd-medication-vs
Title: "SCD Medication Value Set"
Description: """
  Value set of RxNorm codes for medications used in Sickle Cell Disease
  management, including disease-modifying therapies, gene therapies, iron
  chelation agents, prophylactic antibiotics, folic acid supplementation,
  analgesics, anticoagulants and antiplatelets, and epoetin alfa.
  The codes are RxNorm ingredient codes, for grouping and display. Exchanged
  medication codes follow the US Core binding (clinical drug codes).

  RxNorm ingredient codes verified against RxNav (October 2026).
"""
* ^status = #draft
* ^purpose = "Reference list of medications used in SCD care. It adds no conformance requirement beyond US Core."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"
* ^copyright = "RxNorm is in the public domain (NLM)."

// Disease-Modifying Therapies
* $rxnorm#5552  "hydroxyurea"               // Droxia, Siklos (SCD-labeled brands)
* $rxnorm#4885 "glutamine"   // Endari (L-glutamine oral powder)
* $rxnorm#2262279 "crizanlizumab"             // Adakveo
* $rxnorm#2265678 "voxelotor"                 // Oxbryta (withdrawn September 2024; historical records only)

// Gene Therapies
* $rxnorm#2671667 "exagamglogene autotemcel"   // Casgevy
* $rxnorm#2671958 "lovotibeglogene autotemcel" // Lyfgenia

// Iron Chelation Agents
* $rxnorm#614373  "deferasirox"               // Exjade, Jadenu
* $rxnorm#3131    "deferoxamine"              // Desferal
* $rxnorm#11645   "deferiprone"               // Ferriprox

// Antibiotic Prophylaxis (asplenia)
* $rxnorm#7984    "penicillin V"
* $rxnorm#723    "amoxicillin"

// Folic acid supplementation (common practice; evidence is limited)
* $rxnorm#4511   "folic acid"


// Added from the USCDI+ SCD value set workbook review (2026-11-22); verified on tx.fhir.org
// Analgesics, anticoagulants and antiplatelets, and epoetin alfa
* $rxnorm#5640  "ibuprofen"
* $rxnorm#161  "acetaminophen"
* $rxnorm#35827  "ketorolac"
* $rxnorm#7052  "morphine"
* $rxnorm#4337  "fentanyl"
* $rxnorm#3423  "hydromorphone"
* $rxnorm#6130  "ketamine"
* $rxnorm#1819  "buprenorphine"
* $rxnorm#1191  "aspirin"
* $rxnorm#32968  "clopidogrel"
* $rxnorm#1364430  "apixaban"
* $rxnorm#1114195  "rivaroxaban"
* $rxnorm#1599538  "edoxaban"
* $rxnorm#1037042  "dabigatran etexilate"
* $rxnorm#15202  "argatroban"
* $rxnorm#105694  "epoetin alfa"
* $rxnorm#5224  "heparin"
* $rxnorm#67108  "enoxaparin"
* $rxnorm#11289  "warfarin"


// ==============================================================================
// SCDLaboratoryPanelVS — SCD Relevant Laboratory Tests
// ==============================================================================
// For use with SCDObservationLaboratoryResult.code (LOINC)
// ==============================================================================

// TODO: Expand with complete LOINC coverage.
ValueSet: SCDLaboratoryPanelVS
Id: scd-laboratory-panel-vs
Title: "SCD Laboratory Panel Value Set"
Description: """
  Value set of LOINC codes for laboratory tests routinely ordered and reported
  in the monitoring and management of Sickle Cell Disease. Covers CBC,
  hemoglobin fractionation, hemolysis markers, iron studies (including liver
  iron concentration), renal function, hepatic function, immunohematology
  (ABO and Rh group, antibody screen and identification, direct antiglobulin
  test and red cell antigen typing), infection markers (blood culture and
  C-reactive protein), lipids, urine protein and creatinine, pregnancy testing
  (beta hCG) and the hemoglobinopathies newborn screening panel.
"""
* ^status = #draft
* ^purpose = "Reference list of laboratory tests commonly used in SCD care. It adds no conformance requirement beyond US Core."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995+, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc."

// Complete Blood Count (CBC)
* $loinc#718-7    "Hemoglobin [Mass/volume] in Blood"
* $loinc#4544-3   "Hematocrit [Volume Fraction] of Blood by Automated count"
* $loinc#787-2    "MCV [Entitic mean volume] in Red Blood Cells by Automated count"
* $loinc#6690-2   "Leukocytes [#/volume] in Blood by Automated count"
* $loinc#751-8    "Neutrophils [#/volume] in Blood by Automated count"
* $loinc#777-3    "Platelets [#/volume] in Blood by Automated count"
* $loinc#26515-7  "Platelets [#/volume] in Blood"
* $loinc#789-8    "Erythrocytes [#/volume] in Blood by Automated count"

// Reticulocyte Count
* $loinc#17849-1  "Reticulocytes/Erythrocytes in Blood by Automated count"
* $loinc#31112-6  "Reticulocytes/Erythrocytes in Blood by Manual"
* $loinc#60474-4  "Reticulocytes [#/volume] in Blood by Automated count"

// Hemoglobin Fractionation / Electrophoresis
* $loinc#4625-0   "Hemoglobin S/Hemoglobin.total in Blood"         // HbS %
* $loinc#4576-5   "Hemoglobin F/Hemoglobin.total in Blood"         // HbF %
* $loinc#4546-8   "Hemoglobin A/Hemoglobin.total in Blood"         // HbA %
* $loinc#4551-8   "Hemoglobin A2/Hemoglobin.total in Blood"        // HbA2 %
* $loinc#4563-3   "Hemoglobin C/Hemoglobin.total in Blood"         // HbC %
* $loinc#94538-6  "Hemoglobin HPLC and electrophoresis panel - Blood"
* $loinc#12710-0  "Hemoglobin pattern [Interpretation] in Blood"

// Hemolysis Markers
* $loinc#14804-9  "Lactate dehydrogenase [Enzymatic activity/volume] in Serum or Plasma by Lactate to pyruvate reaction"
* $loinc#1975-2   "Bilirubin.total [Mass/volume] in Serum or Plasma"
* $loinc#1968-7   "Bilirubin.direct [Mass/volume] in Serum or Plasma"
* $loinc#4542-7   "Haptoglobin [Mass/volume] in Serum or Plasma"

// Iron Studies
* $loinc#2276-4   "Ferritin [Mass/volume] in Serum or Plasma"
* $loinc#2498-4   "Iron [Mass/volume] in Serum or Plasma"
* $loinc#2500-7   "Iron binding capacity [Mass/volume] in Serum or Plasma"
* $loinc#2502-3   "Iron saturation [Mass Fraction] in Serum or Plasma"

// Renal Function
* $loinc#2160-0   "Creatinine [Mass/volume] in Serum or Plasma"
* $loinc#62238-1  "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI)/1.73 sq M"
* $loinc#98979-8  "Glomerular filtration rate [Volume Rate/Area] in Serum, Plasma or Blood by Creatinine-based formula (CKD-EPI 2021)/1.73 sq M"
* $loinc#14959-1  "Microalbumin/Creatinine [Mass Ratio] in Urine"
* $loinc#9318-7   "Albumin/Creatinine [Mass Ratio] in Urine"
* $loinc#1754-1   "Albumin [Mass/volume] in Urine"

// Hepatic Function
* $loinc#1742-6   "Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* $loinc#1920-8   "Aspartate aminotransferase [Enzymatic activity/volume] in Serum or Plasma"
* $loinc#6768-6   "Alkaline phosphatase [Enzymatic activity/volume] in Serum or Plasma"

// Cardiac / Pulmonary Biomarker (the ASH 2019 cardiopulmonary and kidney
// guideline notes NT-proBNP may help evaluate suspected pulmonary hypertension
// after an abnormal echocardiogram)
* $loinc#33762-6  "Natriuretic peptide.B prohormone N-Terminal [Mass/volume] in Serum or Plasma"

// Immunohematology
* $loinc#883-9    "ABO group [Type] in Blood"
* $loinc#10331-7  "Rh [Type] in Blood"
* $loinc#890-4    "Blood group antibody screen [Presence] in Serum or Plasma"
* $loinc#888-8  "Blood group antibodies identified in Serum or Plasma"

// Transfusion, infection and organ screening tests (added after clinical review)
* $loinc#1007-4  "Direct antiglobulin test.polyspecific reagent [Presence] on Red Blood Cells"   // direct antiglobulin test
* $loinc#948-0  "C Ag [Presence] on Red Blood Cells"   // C antigen typing
* $loinc#13310-8  "Kell group Ag [Type] on Red Blood Cells"   // Kell antigen typing
* $loinc#57028-3  "Iron [Mass/mass] in Liver"   // liver iron concentration
* $loinc#600-7  "Bacteria identified in Blood by Culture"   // blood culture
* $loinc#1988-5  "C reactive protein [Mass/volume] in Serum or Plasma"   // CRP
// TCD velocity (for example LOINC 11674-9) and tricuspid regurgitant jet velocity are
// imaging measurements, not laboratory tests, so they are not listed here.

// Added from the USCDI+ SCD value set workbook review (2026-11-22); verified on tx.fhir.org
* $loinc#1751-7  "Albumin [Mass/volume] in Serum or Plasma"
* $loinc#21198-7  "Choriogonadotropin.beta subunit [Units/volume] in Serum or Plasma"
* $loinc#882-1  "ABO and Rh group [Type] in Blood"
* $loinc#3094-0  "Urea nitrogen [Mass/volume] in Serum or Plasma"
* $loinc#58410-2  "CBC panel - Blood by Automated count"
* $loinc#2085-9  "Cholesterol in HDL [Mass/volume] in Serum or Plasma"
* $loinc#49322-1  "Hemoglobin pattern [Interpretation] in Blood by HPLC"
* $loinc#13457-7  "Cholesterol in LDL [Mass/volume] in Serum or Plasma by calculation"
* $loinc#54081-5  "Hemoglobinopathies newborn screening panel"
* $loinc#2161-8  "Creatinine [Mass/volume] in Urine"
* $loinc#2888-6  "Protein [Mass/volume] in Urine"


// ==============================================================================
// SCDProcedureVS — SCD Relevant Procedures
// ==============================================================================
// Reference list for SCDProcedure.code (SNOMED CT; CPT codes may be added)
// ==============================================================================

// TODO: Add complete CPT code coverage.
ValueSet: SCDProcedureVS
Id: scd-procedure-vs
Title: "SCD Procedure Value Set"
Description: """
  Value set of codes representing procedures commonly performed in the
  management of Sickle Cell Disease, including transfusion, exchange
  transfusion, stem cell collection and transplantation, gene therapy,
  cholecystectomy, hip replacement and diagnostic monitoring procedures (such
  as transcranial Doppler and liver MRI).
"""
* ^status = #draft
* ^purpose = "Reference list of procedures commonly performed in SCD care. It adds no conformance requirement beyond US Core."
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Transfusion Procedures (SNOMED CT)
* $sct#116863004  "Transfusion of red blood cells"                // simple transfusion
* $sct#71493000   "Transfusion of packed red blood cells"         // simple transfusion
* $sct#438839005  "Erythrocytapheresis"                           // automated red cell exchange
* $sct#225068002  "Red cell exchange transfusion"                 // manual or automated exchange
* $sct#5447007    "Transfusion"

// Stem Cell Transplantation
* $sct#23719005   "Transplantation of bone marrow"
* $sct#234336002  "Hemopoietic stem cell transplant"
* $sct#174241000112100  "Transplantation of allogeneic hematopoietic stem cell"

// Phlebotomy
* $sct#396540005  "Phlebotomy"

// Splenectomy
* $sct#234319005  "Splenectomy"

// Monitoring Procedures
* $sct#431648005  "Transcranial Doppler ultrasonography"
* $sct#40701008   "Echocardiography"   // ASH 2019 suggests against routine screening echo in asymptomatic patients

// Vascular Access
* $sct#425196008  "Insertion of peripherally inserted central catheter"
* $sct#80402001  "Implantation of venous access port"

// Other SCD procedures (added after clinical review)
* $sct#38102005  "Cholecystectomy"   // cholecystectomy
* $sct#52734007  "Total replacement of hip"   // hip replacement (avascular necrosis)
* $sct#241622002  "MRI of liver"   // MRI of liver (liver iron)
* $sct#394613000  "Gene therapy"   // gene therapy
* $sct#418576007  "Harvesting of peripheral blood stem cells"   // stem cell collection
// TODO: Terminologist to choose a SNOMED CT code for the dilated retinal examination
// (no matching concept was found).


// ==============================================================================
// SCDBloodProductTypeVS — Blood Product Types Used in SCD
// ==============================================================================
// For use with SCDBiologicallyDerivedProduct.productCode
// ==============================================================================

ValueSet: SCDBloodProductTypeVS
Id: scd-blood-product-type-vs
Title: "SCD Blood Product Type Value Set"
Description: """
  Value set of codes representing blood product types used in the care of
  patients with Sickle Cell Disease, including red blood cell products and
  hematopoietic progenitor cell products for transplantation.

  Codes sourced from SNOMED CT. ISBT 128 codes are planned for a future
  version.
"""
* ^status = #draft
* ^purpose = "Example codes for blood product types used in SCD care, bound with example strength to BiologicallyDerivedProduct.productCode."
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Red Blood Cell Products
* $sct#431069006  "Packed red blood cells"
* $sct#126256009  "Red blood cells, human, irradiated"
* $sct#126251004  "Leukocyte reduced red blood cells, human"
// TODO: add a code for apheresis-collected red blood cells (no SNOMED CT
//       equivalent found; consider ISBT 128)

// Hematopoietic Progenitor Cell Products
* $sct#1351653002 "Stem cells, apheresis"
// TODO: SNOMED CT has no product concept for hematopoietic progenitor cells from
//       bone marrow or cord blood (the former codes 419252003 and 767410002 are
//       not in SNOMED CT). Add ISBT 128 codes for these products when available.

// Washed red cells
* $sct#126249003  "Washed red blood cells, human"   // washed red cells


// ==============================================================================
// SCDVitalSignsVS — SCD Relevant Vital Signs
// ==============================================================================
// For use with SCDObservationVitalSigns.code (LOINC)
// ==============================================================================

ValueSet: SCDVitalSignsVS
Id: scd-vital-signs-vs
Title: "SCD Vital Signs Value Set"
Description: """
  Value set of LOINC codes for vital signs especially relevant to monitoring
  patients with Sickle Cell Disease: a reference list of vital-sign codes used
  in US Core, plus pain severity scores used to assess vaso-occlusive crises.
  It does not include every code in the US Core vital signs value set.
"""
* ^status = #draft
* ^purpose = "Reference list of vital signs and pain scores relevant to SCD. It adds no conformance requirement beyond US Core."
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995+, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Standard Vital Signs (aligned with US Core)
* $loinc#2708-6   "Oxygen saturation in Arterial blood"   // required by US Core for SpO2
* $loinc#59408-5  "Oxygen saturation in Arterial blood by Pulse oximetry"
* $loinc#8310-5   "Body temperature"
* $loinc#85354-9  "Blood pressure panel with all children optional"
* $loinc#8480-6   "Systolic blood pressure"
* $loinc#8462-4   "Diastolic blood pressure"
* $loinc#8867-4   "Heart rate"
* $loinc#9279-1   "Respiratory rate"
* $loinc#29463-7  "Body weight"
* $loinc#8302-2   "Body height"
* $loinc#39156-5  "Body mass index (BMI) [Ratio]"

// SCD-Critical Vital Signs
* $loinc#38208-5  "Pain severity - Reported"
* $loinc#72514-3  "Pain severity - 0-10 verbal numeric rating [Score] - Reported"

// ==============================================================================
// SCDBloodProductProcessingVS — Blood Product Processing Steps and Attributes
// ==============================================================================
// For use with SCDBiologicallyDerivedProduct.processing.procedure
// ==============================================================================

ValueSet: SCDBloodProductProcessingVS
Id: scd-blood-product-processing-vs
Title: "SCD Blood Product Processing Value Set"
Description: """
  Value set of blood product processing steps and attributes relevant to
  transfusion therapy in Sickle Cell Disease, such as leukoreduction,
  irradiation, HbS-negative units and extended antigen matching. Includes all
  codes from the SCD Blood Product Processing code system.
"""
* ^status = #draft
* ^purpose = "Example codes for blood product processing steps and attributes, bound with example strength to BiologicallyDerivedProduct.processing.procedure."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

* include codes from system SCDBloodProductProcessingCS


// ==============================================================================
// SCDRedCellAntigenVS — SCD Red Cell Antigens
// (referenced by SCDTransfusionAntigenMatchExtension)
// ==============================================================================

// TODO: Map to ISBT 128 antigen codes (primary coding system for blood banking).
//       SNOMED CT codes used as placeholder pending ISBT 128 integration.
ValueSet: SCDRedCellAntigenVS
Id: scd-red-cell-antigen-vs
Title: "SCD Red Cell Antigen Value Set"
Description: """
  Value set of codes representing red cell blood group antigens used in
  extended antigen-matched transfusion for Sickle Cell Disease patients.
  Covers antigens in the Rh, Kell, Duffy, Kidd, and MNS blood group systems.

  Coded with SNOMED CT. ISBT 128 antigen codes are planned for a future version.
"""
* ^status = #draft
* ^purpose = "Example codes for red cell antigens matched for transfusion, bound with example strength in the SCD Transfusion Red Cell Antigen Match extension."
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* ^experimental = false
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Rh System
* $sct#84538003   "Blood group antigen C"
* $sct#3807007    "Blood group antigen c"
* $sct#36744004   "Blood group antigen E"
* $sct#64259001   "Blood group antigen e"

// Kell System
* $sct#74652001   "Blood group antigen K"
* $sct#259759002  "Blood group antigen k"

// Duffy System
* $sct#11770009   "Blood group antigen Fy^a^"
* $sct#24574004   "Blood group antigen Fy^b^"

// Kidd System
* $sct#65887005   "Blood group antigen Jk^a^"
* $sct#33825006   "Blood group antigen Jk^b^"

// MNS System
* $sct#19945000   "Blood group antigen M"
* $sct#14090005   "Blood group antigen N"
* $sct#9672005    "Blood group antigen S"
* $sct#45992000   "Blood group antigen s"

// Rh system: D antigen
* $sct#876000  "Blood group antigen D"   // RhD

