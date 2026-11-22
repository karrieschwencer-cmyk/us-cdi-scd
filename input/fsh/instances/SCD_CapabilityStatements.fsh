// ==============================================================================
// USCDI-SCD CapabilityStatements
// File: input/fsh/instances/SCD_CapabilityStatements.fsh
//
// Defines the CapabilityStatement instances for:
//   - USCDI-SCD Server — systems that expose SCD data
//   - USCDI-SCD Client — systems that consume SCD data
//
// These CapabilityStatements define conformance expectations for FHIR
// servers and clients implementing the USCDI-SCD IG.
//
// Each statement imports the matching US Core 8.0.1 CapabilityStatement, which
// supplies the interactions, search parameters and _include requirements.
// Only what this guide adds is listed here: the USCDI-SCD profile for each
// resource, and BiologicallyDerivedProduct, which US Core does not cover.
//
// TODO: Add SMART on FHIR scope requirements.
// ==============================================================================


// ==============================================================================
// USCDI-SCD Server CapabilityStatement
// ==============================================================================
// Applies to: EHR systems, health information exchanges, and specialty
//             systems that expose SCD patient data via FHIR API
// ==============================================================================

Instance: uscdi-scd-server-capabilitystatement
InstanceOf: CapabilityStatement
Title: "USCDI-SCD Server CapabilityStatement"
Description: """
  Defines the minimum FHIR API capabilities required for a system acting as
  a FHIR server (data responder) conformant with the USCDI-SCD Implementation
  Guide. Servers SHALL support read and search operations for all required
  USCDI-SCD profiles.
"""
Usage: #definition

* id = "uscdi-scd-server"
* url = "http://hl7.org/fhir/us/uscdi-scd/CapabilityStatement/uscdi-scd-server"
* name = "USCDISCDServerCapabilityStatement"
* title = "USCDI-SCD Server CapabilityStatement"
* status = #draft
// CapabilityStatement.date is required (1..1); update it when this statement changes.
* date = "2026-11-21"
* experimental = false
* purpose = "States what a server needs to support so that clients can retrieve SCD data for the SCD Diagnosis and SCD Emergency Care use cases."
* publisher = "HL7 International / Public Health"
* description = """
  Minimum server capabilities for systems conformant with the USCDI+ Sickle
  Cell Disease Implementation Guide. Servers SHALL implement the US Core 8.0.1
  Server CapabilityStatement, which this statement imports, and additionally
  support the USCDI-SCD profiles listed below.
"""
* kind = #requirements
* imports[+] = "http://hl7.org/fhir/us/core/CapabilityStatement/us-core-server|8.0.1"
* fhirVersion = #4.0.1
* format[+] = #application/fhir+json
* format[+] = #application/fhir+xml
* implementationGuide[+] = "http://hl7.org/fhir/us/core/ImplementationGuide/hl7.fhir.us.core"
* implementationGuide[+] = "http://hl7.org/fhir/us/uscdi-scd/ImplementationGuide/hl7.fhir.us.uscdi-scd"

* rest[+].mode = #server
* rest[=].documentation = """
  Interactions and search parameters for every resource except
  BiologicallyDerivedProduct come from the imported US Core 8.0.1 Server
  CapabilityStatement, so they are not repeated in the table below. See
  Exchange Workflow, Step 3, for the searches used in each use case.

  USCDI-SCD Server SHALL:
  1. Support all US Core 8.0.1 Server requirements, including the interactions
     and search parameters in the imported US Core Server CapabilityStatement
  2. Support the USCDI-SCD profiles marked SHALL below, using the interactions
     and searches in the imported US Core Server CapabilityStatement
  3. Support SMART App Launch (standalone launch, EHR launch)
  4. Use TLS 1.2 or higher for all connections
  5. Support FHIR AuditEvent for access logging
"""

// Patient
* rest[=].resource[+].type = #Patient
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-patient"

// Practitioner
* rest[=].resource[+].type = #Practitioner
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-practitioner"

// PractitionerRole
* rest[=].resource[+].type = #PractitionerRole
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-practitionerrole"

// Organization
* rest[=].resource[+].type = #Organization
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-organization"

// Location
* rest[=].resource[+].type = #Location
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-location"

// Encounter
* rest[=].resource[+].type = #Encounter
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-encounter"

// Condition
* rest[=].resource[+].type = #Condition
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-condition-encounter-diagnosis"
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-condition-problems"

// AllergyIntolerance
* rest[=].resource[+].type = #AllergyIntolerance
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-allergyintolerance"

// CarePlan
* rest[=].resource[+].type = #CarePlan
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-careplan"

// ServiceRequest
* rest[=].resource[+].type = #ServiceRequest
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-servicerequest"

// Medication
* rest[=].resource[+].type = #Medication
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-medication"

// MedicationRequest
* rest[=].resource[+].type = #MedicationRequest
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-medicationrequest"

// Procedure
* rest[=].resource[+].type = #Procedure
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-procedure"

// Observation (Laboratory Result and Vital Signs)
* rest[=].resource[+].type = #Observation
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-laboratory-result"
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-vital-signs"

// BiologicallyDerivedProduct (not covered by US Core)
// TODO: Define search parameters for BiologicallyDerivedProduct (FHIR R4 has
//       no patient search parameter for this resource) (OQ-7).
* rest[=].resource[+].type = #BiologicallyDerivedProduct
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-biologicallyderivedproduct"
* rest[=].resource[=].interaction[+].code = #read
* rest[=].resource[=].interaction[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[=].resource[=].interaction[=].extension[=].valueCode = #SHOULD
* rest[=].resource[=].interaction[+].code = #search-type
* rest[=].resource[=].interaction[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[=].resource[=].interaction[=].extension[=].valueCode = #SHOULD
* rest[=].resource[=].documentation = """
  BiologicallyDerivedProduct support is RECOMMENDED (SHOULD) for systems that
  manage blood product transfusion records for people with SCD. Systems that do
  not manage transfusion records MAY omit this resource.
"""


// ==============================================================================
// USCDI-SCD Client CapabilityStatement
// ==============================================================================
// Applies to: Clinical applications, patient portals, care management
//             systems, and analytics platforms that consume SCD data
//
// TODO: Add specific client requirements for SCD workflows.
// ==============================================================================

Instance: uscdi-scd-client-capabilitystatement
InstanceOf: CapabilityStatement
Title: "USCDI-SCD Client CapabilityStatement"
Description: """
  Defines the minimum FHIR API capabilities required for a system acting as
  a FHIR client (data requestor) conformant with the USCDI-SCD Implementation
  Guide. Clients SHALL be capable of processing all Must Support elements
  in USCDI-SCD profiles.
"""
Usage: #definition

* id = "uscdi-scd-client"
* url = "http://hl7.org/fhir/us/uscdi-scd/CapabilityStatement/uscdi-scd-client"
* name = "USCDISCDClientCapabilityStatement"
* title = "USCDI-SCD Client CapabilityStatement"
* status = #draft
// CapabilityStatement.date is required (1..1); update it when this statement changes.
* date = "2026-11-21"
* experimental = false
* purpose = "States what a client needs to support to retrieve and use SCD data for the SCD Diagnosis and SCD Emergency Care use cases."
* publisher = "HL7 International / Public Health"
* description = """
  Minimum client capabilities for systems conformant with the USCDI+ Sickle
  Cell Disease Implementation Guide. Clients SHALL implement the US Core 8.0.1
  Client CapabilityStatement, which this statement imports, and additionally
  be capable of consuming USCDI-SCD profile data.
"""
* kind = #requirements
* imports[+] = "http://hl7.org/fhir/us/core/CapabilityStatement/us-core-client|8.0.1"
* fhirVersion = #4.0.1
* format[+] = #application/fhir+json
* format[+] = #application/fhir+xml
* implementationGuide[+] = "http://hl7.org/fhir/us/core/ImplementationGuide/hl7.fhir.us.core"
* implementationGuide[+] = "http://hl7.org/fhir/us/uscdi-scd/ImplementationGuide/hl7.fhir.us.uscdi-scd"

* rest[+].mode = #client
* rest[=].documentation = """
  Interactions and search parameters for every resource except
  BiologicallyDerivedProduct come from the imported US Core 8.0.1 Client
  CapabilityStatement, so they are not repeated in the table below. See
  Exchange Workflow, Step 3, for the searches used in each use case.

  USCDI-SCD Clients SHALL:
  1. Support all US Core 8.0.1 Client requirements, including the interactions
     and search parameters in the imported US Core Client CapabilityStatement
  2. Be capable of requesting and processing the USCDI-SCD profiles marked SHALL below
  3. Process all Must Support elements in USCDI-SCD profiles without error
  4. Handle missing data using dataAbsentReason where applicable
  5. Display SCD-relevant clinical data in human-readable form

  USCDI-SCD Clients SHOULD:
  1. Support the USCDI-SCD profiles marked SHOULD below
"""

// Patient
* rest[=].resource[+].type = #Patient
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-patient"

// Condition
* rest[=].resource[+].type = #Condition
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-condition-encounter-diagnosis"
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-condition-problems"

// Encounter
* rest[=].resource[+].type = #Encounter
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-encounter"

// Observation
* rest[=].resource[+].type = #Observation
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-laboratory-result"
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-vital-signs"

// Procedure
* rest[=].resource[+].type = #Procedure
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-procedure"

// AllergyIntolerance
* rest[=].resource[+].type = #AllergyIntolerance
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-allergyintolerance"

// MedicationRequest
* rest[=].resource[+].type = #MedicationRequest
* insert Expectation(SHALL)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-medicationrequest"

// Practitioner
* rest[=].resource[+].type = #Practitioner
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-practitioner"

// PractitionerRole
* rest[=].resource[+].type = #PractitionerRole
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-practitionerrole"

// Organization
* rest[=].resource[+].type = #Organization
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-organization"

// Location
* rest[=].resource[+].type = #Location
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-location"

// Medication
* rest[=].resource[+].type = #Medication
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-medication"

// CarePlan
* rest[=].resource[+].type = #CarePlan
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-careplan"

// ServiceRequest
* rest[=].resource[+].type = #ServiceRequest
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-servicerequest"

// BiologicallyDerivedProduct (not covered by US Core)
* rest[=].resource[+].type = #BiologicallyDerivedProduct
* insert Expectation(SHOULD)
* rest[=].resource[=].supportedProfile[+] = "http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-biologicallyderivedproduct"
* rest[=].resource[=].interaction[+].code = #read
* rest[=].resource[=].interaction[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[=].resource[=].interaction[=].extension[=].valueCode = #SHOULD
* rest[=].resource[=].interaction[+].code = #search-type
* rest[=].resource[=].interaction[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[=].resource[=].interaction[=].extension[=].valueCode = #SHOULD
* rest[=].resource[=].documentation = "Client SHOULD support retrieval and display of blood product information for SCD transfusion history review."

// ==============================================================================
// RuleSet: per-resource conformance expectation (SHALL | SHOULD | MAY)
// ==============================================================================

RuleSet: Expectation(level)
* rest[=].resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[=].resource[=].extension[=].valueCode = #{level}
