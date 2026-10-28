import 'package:flutter/material.dart';
import 'package:trakmate_portal/src/ui/widgets/legal_page_layout.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPageLayout(
      title: "Terms & Conditions",
      subtitle:
          "Please read these terms carefully before using the Trakmate website.",
      effectiveDate: "28 October 2026",
      intro:
          "Welcome to the website of Trakmate Design Solutions Pvt. Ltd. (“Trakmate”, “we”, “our” or “us”). By accessing or using our website, you agree to these Terms & Conditions. If you do not agree, please discontinue use of the website.",
      sections: [
        LegalSection(
          number: "1",
          title: "About Us",
          paragraphs: [
            "Trakmate Design Solutions Pvt. Ltd. provides technology-related products and services, which may include IoT solutions, asset tracking, fleet management, embedded systems, software development, and related services.",
          ],
        ),
        LegalSection(
          number: "2",
          title: "Use of the Website",
          paragraphs: [
            "You agree to use this website only for lawful purposes. You must not misuse the website, attempt unauthorized access, introduce malicious software, or interfere with its functionality.",
          ],
        ),
        LegalSection(
          number: "3",
          title: "Product and Service Information",
          paragraphs: [
            "We aim to keep all product descriptions, specifications, images, and service information accurate and up to date. However, information displayed on the website may change without prior notice. Final specifications, pricing, delivery schedules, and service commitments will be governed by the applicable quotation, purchase order, or written agreement.",
          ],
        ),
        LegalSection(
          number: "4",
          title: "Intellectual Property",
          paragraphs: [
            "All website content, including text, graphics, logos, images, designs, and software, belongs to Trakmate or its respective licensors unless otherwise stated. You may not reproduce, distribute, modify, or commercially use this content without prior written permission.",
          ],
        ),
        LegalSection(
          number: "5",
          title: "Enquiries and Communications",
          paragraphs: [
            "Submitting an enquiry or contact form does not automatically create a business relationship or confirm an order. Any engagement will be subject to written confirmation and applicable contractual terms.",
          ],
        ),
        LegalSection(
          number: "6",
          title: "Third-Party Links",
          paragraphs: [
            "Our website may contain links to third-party websites. Trakmate is not responsible for their content, availability, security, or privacy practices.",
          ],
        ),
        LegalSection(
          number: "7",
          title: "Limitation of Liability",
          paragraphs: [
            "To the extent permitted by applicable law, Trakmate shall not be liable for indirect or consequential losses arising from the use of this website or temporary website unavailability. Nothing in these terms excludes liability that cannot legally be excluded.",
          ],
        ),
        LegalSection(
          number: "8",
          title: "Changes to These Terms",
          paragraphs: [
            "We may update these Terms & Conditions from time to time. Changes will be published on this page with an updated effective date.",
          ],
        ),
        LegalSection(
          number: "9",
          title: "Governing Law",
          paragraphs: [
            "These terms shall be governed by the laws of India. Jurisdiction and dispute resolution will be subject to applicable law and any valid contractual arrangements.",
          ],
        ),
        LegalSection(
          number: "10",
          title: "Contact Us",
          paragraphs: [
            "For questions regarding these Terms & Conditions, contact:",
          ],
          contacts: [
            LegalContactLine(
              Icons.business_rounded,
              "Trakmate Design Solutions Pvt. Ltd.",
            ),
            LegalContactLine(
              Icons.mail_outline_rounded,
              "Email: [Insert official contact email]",
            ),
            LegalContactLine(
              Icons.location_on_outlined,
              "Address: [Insert registered office address]",
            ),
          ],
        ),
      ],
    );
  }
}
