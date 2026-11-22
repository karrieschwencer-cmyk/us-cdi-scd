{%- comment -%}
SECURITY AND PRIVACY PAGE — security.md
{%- endcomment -%}

Sickle cell disease (SCD) data is sensitive health information. In the United States, SCD occurs in about 1 in 365 Black or African American births ([CDC](references.html#cdc-scd-data)), and the [ASH 2020 pain guideline](references.html#ash-2020-pain) describes stigma and discrimination that people with SCD can face when seeking emergency care. Implementers are responsible for complying with HIPAA ([45 CFR Parts 160 and 164](references.html#hipaa-privacy-rule)) and other applicable federal and state privacy laws. Where exchanged data includes substance use disorder treatment records from programs covered by [42 CFR Part 2](references.html#cfr-part-2), those records are also subject to Part 2.

---

### General Security Guidance

Servers SHALL meet the security requirements in [Conformance Requirements](conformance.html#capabilitystatements). Implementers should also follow:

- [FHIR R4 Security](http://hl7.org/fhir/R4/security.html)
- [US Core 8.0.1 Security](http://hl7.org/fhir/us/core/STU8.0.1/security.html)
- [SMART App Launch](http://hl7.org/fhir/smart-app-launch/) for authentication and authorization
- TLS 1.2 or higher for transport security
- Audit logging with the FHIR [AuditEvent](http://hl7.org/fhir/R4/auditevent.html) resource

---

### Sensitive Data Considerations for SCD

1. **Substance use and pain medication history.** Opioid prescribing records need care. The [ASH 2020 pain guideline](references.html#ash-2020-pain) notes that people with SCD in the emergency department may be labeled as drug seeking, and that this stigma could be magnified during the opioid epidemic. Substance use disorder treatment records from programs covered by [42 CFR Part 2](references.html#cfr-part-2) have additional restrictions.
2. **Mental health.** Records may include mental health information. The [ASH 2020 pain guideline](references.html#ash-2020-pain) calls routine screening for depression and anxiety good practice in people with SCD and pain, given the prevalence of psychological comorbidities.
3. **Race and ethnicity.** Race and ethnicity are not among the identifiers that the HIPAA Safe Harbor method requires removing ([45 CFR 164.514(b)(2)](references.html#hipaa-deidentification)), but combined with an SCD diagnosis they can increase re-identification risk in small populations. Consider this when de-identifying data.
4. **Minors.** Access to minors' records is governed by the HIPAA personal-representative rules ([45 CFR 164.502(g)](references.html#hipaa-personal-representatives)) and state minor-consent laws.

---

### Recommendations for Implementers

The recommendations below are informative good practice, not conformance requirements of this guide.

- Implement role-based access control (RBAC) for SCD records
- Apply data segmentation for sensitive elements (such as substance use)
<!-- TODO: Add guidance on representing 42 CFR Part 2 restrictions and data segmentation in FHIR (for example, security labels in meta.security). -->
- Review audit logs of access to SCD records (servers keep an audit log; see [Conformance Requirements](conformance.html#capabilitystatements))
- Implement break-glass procedures for emergency access
- Follow NIST SP 800-53 security controls for health data systems
