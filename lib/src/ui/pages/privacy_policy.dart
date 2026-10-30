import 'package:flutter/material.dart';
import 'package:trakmate_portal/src/ui/widgets/legal_page_layout.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPageLayout(
      title: "Privacy Policy",
      subtitle:
          "How Trakmate collects, uses, discloses and protects your personal information.",
      effectiveDate: "28 October 2026",
      intro:
          "Trakmate Design Solutions Pvt. Ltd. (“Trakmate”, “we”, “our” or “us”) respects your privacy. This Privacy Policy explains how we collect, use, disclose, and protect personal information when you visit our website or communicate with us.",
      sections: [
        LegalSection(
          number: "1",
          title: "Information We Collect",
          paragraphs: [
            "Depending on how you interact with us, we may collect:",
          ],
          bullets: [
            LegalBullet(
              "Name, email address, telephone number, company name, and other details you submit through enquiry forms.",
              lead: "Contact information",
            ),
            LegalBullet(
              "Requirements, messages, and project-related details you voluntarily provide.",
              lead: "Business enquiry information",
            ),
            LegalBullet(
              "IP address, browser type, device information, pages visited, and website usage data, where collected through server logs or analytics tools.",
              lead: "Technical information",
            ),
            LegalBullet(
              "Details contained in resumes or applications submitted to us, if recruitment functionality is available.",
              lead: "Recruitment information",
            ),
          ],
          footer:
              "Please avoid submitting sensitive personal information unless it is necessary for a legitimate purpose and requested through an appropriate channel.",
        ),
        LegalSection(
          number: "2",
          title: "How We Use Your Information",
          paragraphs: ["We may use personal information to:"],
          bullets: [
            LegalBullet("Respond to enquiries and requests."),
            LegalBullet("Provide information about our products and services."),
            LegalBullet(
              "Prepare quotations and manage business relationships.",
            ),
            LegalBullet("Process recruitment applications."),
            LegalBullet(
              "Maintain website security and improve website performance.",
            ),
            LegalBullet("Meet applicable legal and regulatory obligations."),
          ],
          footer:
              "We will use personal information for purposes permitted by applicable law.",
        ),
        LegalSection(
          number: "3",
          title: "Cookies and Analytics",
          paragraphs: [
            "Our website may use cookies or similar technologies to maintain functionality, understand website usage, and improve user experience. The use of optional cookies and analytics tools will be managed in accordance with applicable requirements. You can also manage cookies through your browser settings.",
          ],
        ),
        LegalSection(
          number: "4",
          title: "Sharing of Information",
          paragraphs: [
            "We do not sell personal information as a business practice. We may share information with authorized service providers, hosting providers, analytics providers, professional advisers, or government authorities where necessary and lawful. We expect service providers handling personal information on our behalf to apply appropriate safeguards.",
          ],
        ),
        LegalSection(
          number: "5",
          title: "Data Security",
          paragraphs: [
            "We take reasonable measures designed to protect personal information against unauthorized access, disclosure, alteration, or loss. However, no method of electronic storage or transmission is completely secure.",
          ],
        ),
        LegalSection(
          number: "6",
          title: "Data Retention",
          paragraphs: [
            "We retain personal information only for as long as reasonably necessary for the purpose for which it was collected, including business, contractual, security, and legal requirements. Information may be deleted, anonymized, or securely disposed of when no longer required, subject to applicable law.",
          ],
        ),
        LegalSection(
          number: "7",
          title: "Your Rights and Requests",
          paragraphs: [
            "Subject to applicable law, you may request access to, correction of, or deletion of your personal information, or raise concerns about its processing. You may also withdraw consent where processing is based on consent, subject to legal and contractual limitations.",
          ],
          footer: "To submit a request, contact us using the details below.",
        ),
        LegalSection(
          number: "8",
          title: "Third-Party Websites",
          paragraphs: [
            "Our website may link to external websites or services. Their privacy policies and practices are governed by their respective operators.",
          ],
        ),
        LegalSection(
          number: "9",
          title: "Children's Privacy",
          paragraphs: [
            "Our website is intended for business and general informational use. We do not knowingly collect children's personal information in violation of applicable law.",
          ],
        ),
        LegalSection(
          number: "10",
          title: "Updates to This Policy",
          paragraphs: [
            "We may update this Privacy Policy when our practices or legal obligations change. The latest version and effective date will be displayed on this page.",
          ],
        ),
        LegalSection(
          number: "11",
          title: "Contact Us",
          paragraphs: ["For privacy-related questions or requests:"],
          contacts: [
            LegalContactLine(
              "icons/city.svg",
              "Trakmate Design Solutions Pvt. Ltd.",
            ),
            LegalContactLine("icons/mail.svg", "Email: info@trakmate.co.in"),
            LegalContactLine(
              "icons/location.svg",
              "Address: [Insert registered office address]",
            ),
          ],
        ),
      ],
    );
  }
}
