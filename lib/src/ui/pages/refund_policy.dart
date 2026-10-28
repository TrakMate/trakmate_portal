import 'package:flutter/material.dart';
import 'package:trakmate_portal/src/ui/widgets/legal_page_layout.dart';

class RefundPolicyPage extends StatelessWidget {
  const RefundPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPageLayout(
      title: "Refund & Cancellation Policy",
      subtitle:
          "How cancellations, returns and refunds work for Trakmate products and services.",
      effectiveDate: "28 October 2026",
      intro:
          "This Refund & Cancellation Policy applies to eligible purchases and services offered by Trakmate Design Solutions Pvt. Ltd. (“Trakmate”, “we”, “our” or “us”).",
      sections: [
        LegalSection(
          number: "1",
          title: "Product Orders",
          paragraphs: [
            "Requests to cancel an order for a physical product must be submitted in writing as soon as possible. Cancellation depends on the order's processing, manufacturing, dispatch, and delivery status, as well as the applicable purchase agreement and law.",
          ],
        ),
        LegalSection(
          number: "2",
          title: "Returns and Replacements",
          paragraphs: [
            "If a product is defective, damaged during delivery, incorrect, or materially different from the agreed specifications, please contact us promptly with your order details and supporting photographs or documentation, where applicable.",
            "We will review the issue and provide an appropriate remedy, which may include repair, replacement, return, or refund, as required by applicable law and the relevant order terms.",
          ],
          footer:
              "Products should not be returned without receiving return instructions from our team.",
        ),
        LegalSection(
          number: "3",
          title: "Software and Professional Services",
          paragraphs: [
            "For software development, implementation, consulting, installation, and other professional services, cancellation and refund eligibility will be determined by the applicable quotation, statement of work, milestones, work completed, and contractual terms.",
            "Any refund for work already performed or expenses already incurred will be assessed in accordance with the agreement and applicable law.",
          ],
        ),
        LegalSection(
          number: "4",
          title: "Subscription and Recurring Services",
          paragraphs: [
            "Where subscription or recurring services are offered, cancellation, renewal, and refund conditions will be communicated before purchase or activation. Cancellation of future renewals does not automatically entitle a customer to a refund for a period already used.",
          ],
        ),
        LegalSection(
          number: "5",
          title: "Refund Processing",
          paragraphs: [
            "Once a refund is approved, it will be processed through the original payment method where reasonably possible, or another mutually agreed lawful method. Processing time may depend on the payment provider or bank. Applicable statutory requirements will be followed.",
          ],
        ),
        LegalSection(
          number: "6",
          title: "How to Request a Refund or Cancellation",
          paragraphs: ["Please email [Insert official support email] with:"],
          bullets: [
            LegalBullet("Your name and contact details."),
            LegalBullet("Order number, invoice number, or project reference."),
            LegalBullet("The reason for your request."),
            LegalBullet(
              "Relevant photographs or supporting documents, where applicable.",
            ),
          ],
          footer:
              "Our team will review the request and communicate the next steps.",
        ),
        LegalSection(
          number: "7",
          title: "Exceptions and Legal Rights",
          paragraphs: [
            "Refunds may be subject to the agreed terms for the relevant transaction, except where applicable law provides otherwise. Nothing in this policy limits any non-waivable rights or remedies available to customers under applicable law.",
          ],
        ),
        LegalSection(
          number: "8",
          title: "Contact Us",
          contacts: [
            LegalContactLine(
              Icons.business_rounded,
              "Trakmate Design Solutions Pvt. Ltd.",
            ),
            LegalContactLine(
              Icons.mail_outline_rounded,
              "Email: [Insert official support email]",
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
