This page provides test data for implementers and testers, built from the fictional Maya Johnson scenario described on the [Examples](examples.html) page. All test data is fictional and contains no real patient information.

The scenario follows the SCD Emergency Care use case ([Scenario B](scope_and_usage.html#use-case-scenarios)). Test data for the SCD Diagnosis use case is planned ([KI-12](issues.html#ki-12)).

The test Bundles reuse the example records, so they always match the examples, and they are validated against the profiles every time this guide is built.

For a complete list of profile elements, cardinalities and bindings to test against, see the [Data Element Mapping](data-element-mapping.html) page and its CSV download.

---

### Loading the Test Data

The transaction Bundle contains the 19 records in the Maya Johnson scenario that the CapabilityStatements cover. The hydroxyurea adherence [MedicationStatement](MedicationStatement-maya-johnson-hydroxyurea-adherence.html), which shows an unused extension, is not included.

| Bundle | Download | Contents |
|---|---|---|
| [Maya Johnson Complete Record (Transaction)](Bundle-maya-johnson-test-data-transaction.html) | [JSON](Bundle-maya-johnson-test-data-transaction.json) · [XML](Bundle-maya-johnson-test-data-transaction.xml) | Every example record: patient, practitioners and organization, encounter, conditions, allergy, observations, medications, transfusion order, procedure, blood product and care plan |

To load it, POST the Bundle to the base URL of a FHIR R4 server:

```
POST [base]
Content-Type: application/fhir+json

(contents of Bundle-maya-johnson-test-data-transaction.json)
```

Each entry uses `PUT` with the record's id (for example, `PUT Patient/maya-johnson-patient`), so the load can be repeated without creating duplicate records. The server must allow clients to assign resource ids.

---

### Expected Search Results

After loading the test data, a conformant USCDI-SCD server should return the results below for these searches, which the [USCDI-SCD Server CapabilityStatement](CapabilityStatement-uscdi-scd-server.html) requires through the [US Core 8.0.1 Server CapabilityStatement](http://hl7.org/fhir/us/core/STU8.0.1/CapabilityStatement-us-core-server.html) it imports. Support for `_include=MedicationRequest:medication`, used in the last search, is recommended (SHOULD) rather than required. Each searchset Bundle shows the expected response.

| Search | Expected results | Expected response |
|---|---|---|
| `GET [base]/Patient?identifier=http://example.org/metro-scd-center/mrn\|SCD-2024-00142` | 1 Patient | [Bundle](Bundle-maya-johnson-search-patient.html) ([JSON](Bundle-maya-johnson-search-patient.json)) |
| `GET [base]/Condition?patient=maya-johnson-patient` | 2 Conditions: the problem list SCD diagnosis and the ED encounter diagnosis | [Bundle](Bundle-maya-johnson-search-conditions.html) ([JSON](Bundle-maya-johnson-search-conditions.json)) |
| `GET [base]/Observation?patient=maya-johnson-patient&category=laboratory` | 1 Observation: hemoglobin fractionation | [Bundle](Bundle-maya-johnson-search-labs.html) ([JSON](Bundle-maya-johnson-search-labs.json)) |
| `GET [base]/Observation?patient=maya-johnson-patient&category=vital-signs` | 2 Observations: SpO2 and pain score | [Bundle](Bundle-maya-johnson-search-vitals.html) ([JSON](Bundle-maya-johnson-search-vitals.json)) |
| `GET [base]/MedicationRequest?patient=maya-johnson-patient&intent=order&_include=MedicationRequest:medication` | 2 MedicationRequests (hydroxyurea, deferasirox), plus 1 included Medication (hydroxyurea) | [Bundle](Bundle-maya-johnson-search-medicationrequests.html) ([JSON](Bundle-maya-johnson-search-medicationrequests.json)) |
| `GET [base]/Encounter?patient=maya-johnson-patient` | 1 Encounter: the ED visit | [Bundle](Bundle-maya-johnson-search-encounters.html) ([JSON](Bundle-maya-johnson-search-encounters.json)) |
| `GET [base]/AllergyIntolerance?patient=maya-johnson-patient` | 1 AllergyIntolerance: the NSAID intolerance | [Bundle](Bundle-maya-johnson-search-allergies.html) ([JSON](Bundle-maya-johnson-search-allergies.json)) |
| `GET [base]/Procedure?patient=maya-johnson-patient` | 1 Procedure: the exchange transfusion | [Bundle](Bundle-maya-johnson-search-procedures.html) ([JSON](Bundle-maya-johnson-search-procedures.json)) |
| `GET [base]/CarePlan?patient=maya-johnson-patient&category=assess-plan` | 1 CarePlan: the chronic transfusion plan | [Bundle](Bundle-maya-johnson-search-careplans.html) ([JSON](Bundle-maya-johnson-search-careplans.json)) |
| `GET [base]/ServiceRequest?patient=maya-johnson-patient` | 1 ServiceRequest: the transfusion order | [Bundle](Bundle-maya-johnson-search-servicerequests.html) ([JSON](Bundle-maya-johnson-search-servicerequests.json)) |

Only one Medication is included in the last search because only the hydroxyurea prescription references a Medication resource; the deferasirox prescription codes its medication directly in `medicationCodeableConcept`.

When comparing a server's response with the expected Bundle, compare which records are returned and their search mode (`match` or `include`). Server-specific values such as `Bundle.id`, `meta.lastUpdated`, `fullUrl` and link URLs will differ.

<!-- TODO: Add test data for additional patients (for example, a pediatric
     HbS-beta-0 patient, an HbSC adult, an alloimmunized patient) and a
     missing-data patient that exercises Data Absent Reason and Must Support
     handling. -->

---

### Values for Building Test Data

To build test data for other patients, use the codes in the guide's value sets. They are available as a spreadsheet, [Reference Value Sets (Excel)](uscdi-scd-reference-value-sets.xlsx), with one sheet per value set. The values are reference lists of codes commonly used in SCD care: they do not constrain exchange, and any code valid under US Core is also valid under this guide.

---

### How to Test Conformance

#### Validate your resources

Use the [HL7 FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core/releases) (`validator_cli.jar`; an online version is at [validator.fhir.org](https://validator.fhir.org)) with this guide's FHIR package (`package.tgz` on the [Downloads](downloads.html) page). For example, to check a Patient resource against the USCDI-SCD Patient profile:

```
java -jar validator_cli.jar patient.json -version 4.0.1 -ig package.tgz \
     -profile http://hl7.org/fhir/us/uscdi-scd/StructureDefinition/uscdi-scd-patient
```

The validator loads US Core 8.0.1 and this guide's other dependencies automatically. A resource conforms when the validator reports no errors. Review warnings and information messages, but they do not by themselves mean that the resource fails.

#### Check each requirement

The table shows how each requirement in the [CapabilityStatements](conformance.html#capabilitystatements) can be checked.

| Requirement | How to check |
|---|---|
| Server: support the US Core 8.0.1 Server requirements | Test against the [US Core 8.0.1 Server CapabilityStatement](http://hl7.org/fhir/us/core/STU8.0.1/CapabilityStatement-us-core-server.html) |
| Server: support the profiles marked SHALL | Load the test data, run the searches above, and compare the results with the expected Bundles; validate the returned resources against the profiles |
| Server (SHOULD): BiologicallyDerivedProduct `read` | After loading the test data, `GET [base]/BiologicallyDerivedProduct/prbcs-antigen-matched-example` returns the blood product. No search parameters are defined yet ([OQ-7](issues.html#oq-7)) |
| Server: SMART App Launch, TLS 1.2 or higher, FHIR AuditEvent access logging | Not yet testable from this guide: the authorization model, scopes and the use of AuditEvent are open questions ([OQ-4](issues.html#oq-4)) |
| Client: support the US Core 8.0.1 Client requirements | Test against the [US Core 8.0.1 Client CapabilityStatement](http://hl7.org/fhir/us/core/STU8.0.1/CapabilityStatement-us-core-client.html) |
| Client: request and process the profiles, including Must Support elements, without error | Have the client retrieve the test data from a test server, and confirm that it processes every record and each Must Support element |
| Client: handle missing data | Not yet testable with this guide's test data: a missing-data test patient is planned ([KI-12](issues.html#ki-12)) |
| Client: display SCD data in human-readable form | Manual review; this guide does not define display criteria |
