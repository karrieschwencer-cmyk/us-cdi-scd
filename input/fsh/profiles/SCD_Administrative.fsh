// ==============================================================================
// USCDI-SCD FSH Profiles — Administrative / Demographic
// File: input/fsh/profiles/SCD_Administrative.fsh
//
// Profiles:
//   - SCDPatient
//   - SCDPractitioner
//   - SCDPractitionerRole
//   - SCDOrganization
//   - SCDLocation
//
// All profiles in this file extend their respective US Core 8.0.1 parents.
// US Core parent profiles are reused without modification where possible.
// Additional constraints reflect SCD-specific requirements.
// ==============================================================================


// ==============================================================================
// SCDPatient
// ==============================================================================
// Extends: US Core Patient Profile
// Purpose: Represents patients with Sickle Cell Disease.
//          Inherits all US Core Patient Must Support elements.
//          Race and ethnicity are surfaced as Must Support.
// ==============================================================================

Profile: SCDPatient
Parent: us-core-patient
Id: uscdi-scd-patient
Title: "USCDI-SCD Patient"
Description: """
  The USCDI-SCD Patient profile represents a patient with Sickle Cell Disease (SCD)
  or at risk for SCD. This profile extends the [US Core Patient Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-patient.html)
  and is the patient profile that every other profile in this guide references.

  It adds Must Support to the US Core race and ethnicity extensions, and to
  telecom and preferred
  language (communication). It also allows the SCD Newborn Screen Reference
  extension.
"""

// ----------------------------------------------------------------------------
// Adds Must Support on race, ethnicity, telecom and communication, and allows
// the SCD Newborn Screen Reference extension.
//
// The SCD Newborn Screen Reference extension is allowed on this profile (below).
// TODO: Consider adding a preferred SCD treatment center extension
//   (reference to Organization) in a future version.
// ----------------------------------------------------------------------------

* ^status = #draft
* ^purpose = "Identifies the person with SCD and carries demographics, including race, ethnicity and preferred language, for the SCD Diagnosis and SCD Emergency Care use cases."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Race and ethnicity from US Core — surfaced as Must Support
* extension[us-core-race] MS
* extension[us-core-ethnicity] MS

// SCD-specific: link to the newborn screening result that identified SCD
* extension contains SCDNewbornScreenReferenceExtension named scd-newborn-screen-reference 0..1
* extension[scd-newborn-screen-reference] ^short = "Newborn screening result that identified SCD"

// Core demographics — Must Support added by this guide (US Core marks some of these as additional USCDI requirements)
* identifier MS
* name MS
* telecom MS
* birthDate MS
* address MS
* communication MS


// ==============================================================================
// SCDPractitioner
// ==============================================================================
// Extends: US Core Practitioner Profile
// Purpose: Represents providers involved in SCD care (hematologists, emergency
//          physicians, primary care providers, pain specialists, etc.)
// ==============================================================================

Profile: SCDPractitioner
Parent: us-core-practitioner
Id: uscdi-scd-practitioner
Title: "USCDI-SCD Practitioner"
Description: """
  The USCDI-SCD Practitioner profile represents a healthcare provider involved
  in the care of patients with Sickle Cell Disease. This profile extends the
  [US Core Practitioner Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-practitioner.html)
  without additional constraints, establishing it as the canonical practitioner
  reference for the USCDI-SCD IG.

  Common practitioner types in SCD care include hematologists, emergency medicine
  physicians, primary care providers, pain management specialists, social workers,
  and patient care coordinators.
"""

* ^status = #draft
* ^purpose = "Gives the SCD profiles a consistent reference target for clinicians who diagnose, treat or record care, for the SCD Diagnosis and SCD Emergency Care use cases."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Practitioner
* identifier MS
* identifier[NPI] MS
* name MS


// ==============================================================================
// SCDPractitionerRole
// ==============================================================================
// Extends: US Core PractitionerRole Profile
// Purpose: Represents the role a provider plays within an SCD care team.
//          Specialty codes relevant to SCD care are noted.
// ==============================================================================

Profile: SCDPractitionerRole
Parent: us-core-practitionerrole
Id: uscdi-scd-practitionerrole
Title: "USCDI-SCD PractitionerRole"
Description: """
  The USCDI-SCD PractitionerRole profile represents the role, organization,
  and location associations of a provider involved in SCD care. This profile
  extends the [US Core PractitionerRole Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-practitionerrole.html).

  SCD care teams frequently include providers across multiple specialties and
  organizations. This profile enables systems to represent care team composition,
  including hematology specialists, primary care, emergency, and care management
  roles, supporting care coordination across settings.

  Relevant NUCC specialty codes include:
  - 207RH0000X — Hematology (Internal Medicine)
  - 207RH0003X — Hematology & Oncology
  - 208D00000X — General Practice
"""

* ^status = #draft
* ^purpose = "Records a clinician's role, specialty and organization (for example, a hematologist at an SCD center), for the SCD Diagnosis and SCD Emergency Care use cases."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core PractitionerRole
* practitioner MS
* organization MS
* code MS
* specialty MS
* location MS
* telecom MS
* endpoint MS


// ==============================================================================
// SCDOrganization
// ==============================================================================
// Extends: US Core Organization Profile
// Purpose: Represents organizations providing SCD care (hematology practices,
//          hospitals, FQHCs, SCD treatment centers, blood banks).
// ==============================================================================

Profile: SCDOrganization
Parent: us-core-organization
Id: uscdi-scd-organization
Title: "USCDI-SCD Organization"
Description: """
  The USCDI-SCD Organization profile represents a healthcare organization
  involved in providing care to patients with Sickle Cell Disease. This
  profile extends the [US Core Organization Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-organization.html)
  without additional constraints.

  Relevant organization types in SCD care include:
  - Sickle Cell Disease treatment centers, including those participating in the
    HRSA Sickle Cell Disease Treatment Demonstration Program
  - Hematology and Oncology practices
  - Federally Qualified Health Centers (FQHCs)
  - Academic Medical Centers with SCD programs
  - Hospital Blood Banks and Transfusion Services
  - Community health organizations and patient advocacy groups
"""

* ^status = #draft
* ^purpose = "Gives the SCD profiles a consistent reference target for organizations such as SCD centers, hospitals and laboratories."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Organization
* identifier MS
* active MS
* name MS
* telecom MS
* address MS


// ==============================================================================
// SCDLocation
// ==============================================================================
// Extends: US Core Location Profile
// Purpose: Represents care delivery locations relevant to SCD
//          (ED, infusion center, day hospital, outpatient clinic, HSCT unit).
// ==============================================================================

Profile: SCDLocation
Parent: us-core-location
Id: uscdi-scd-location
Title: "USCDI-SCD Location"
Description: """
  The USCDI-SCD Location profile represents a physical location where SCD
  care is delivered. This profile extends the [US Core Location Profile](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-location.html)
  without additional constraints.

  People with SCD receive care across a broad range of locations, including
  emergency departments (often for vaso-occlusive crisis), outpatient
  hematology clinics, day hospitals and infusion centers (for chronic
  transfusion therapy), and inpatient units (for acute chest syndrome,
  stroke, and hematopoietic stem cell transplantation).
"""

* ^status = #draft
* ^purpose = "Records where SCD care took place (for example, an SCD clinic or emergency department), for the SCD Diagnosis and SCD Emergency Care use cases."
* ^experimental = false
* ^publisher = "HL7 International / Public Health"
* ^jurisdiction = urn:iso:std:iso:3166#US "United States of America"

// Must Support (US Core requirements, plus any added by this guide) from US Core Location
* status MS
* name MS
* telecom MS
* address MS
* managingOrganization MS
