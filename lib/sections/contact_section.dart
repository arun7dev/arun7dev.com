import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/hover_item.dart';
import '../old_portfolio/main.dart' as old_app;
import '../core/constants/strings.dart';
import '../core/constants/fonts.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final horizontalPadding = isMobile ? 30.0 : 100.0;

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.contactNumber,
            style: AppFonts.dots(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.contactTitle,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 40 : 60,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 600,
            child: Text(
              AppStrings.contactIntro,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withOpacity(0.7),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 50),
          HoverItem(
            child: OutlinedButton.icon(
              onPressed: () => _launchUrl('mailto:arun042000@gmail.com'),
              icon: const Icon(Icons.mail_outline),
              label: Text(
                AppStrings.contactCTA,
                style: AppFonts.mono(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                side:
                    BorderSide(color: Theme.of(context).primaryColor, width: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 100),
          // Social Links
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 30,
            runSpacing: 20,
            children: [
              _buildSocialIcon(
                  context, Icons.code, 'GitHub', 'https://github.com/arun7dev'),
              _buildSocialIcon(context, Icons.shop_two, 'Google Play',
                  'https://play.google.com/store/apps/dev?id=5595603757420873953'),
              _buildSocialIcon(
                  context, Icons.phone, '8072269982', 'tel:8072269982'),
              _buildSocialIcon(context, Icons.location_on, 'Chennai, India', ''),
            ],
          ),
          const SizedBox(height: 80),
          // Easter Egg to Old Portfolio
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const old_app.MyApp()),
              );
            },
            child: Text(
              AppStrings.contactOldPortfolio,
              style: AppFonts.mono(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withOpacity(0.4),
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String tooltip, String url) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: url.isNotEmpty ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: url.isNotEmpty ? () => _launchUrl(url) : null,
          child: HoverItem(
            translate: const Offset(0, -8),
            scale: 1.2,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
