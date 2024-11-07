import 'package:flutter/material.dart';


class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        centerTitle: true,
        title: const Text('Guide d\'utilisation'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.blue.shade200],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildHelpSection(
                icon: Icons.login,
                title: 'Connexion',
                description: 'Connectez-vous à votre compte pour accéder à l\'application.',
              ),
              _buildHelpSection(
                icon: Icons.search,
                title: 'Recherche de colis',
                description: 'Après la connexion, recherchez le numéro du colis reçu. Si le colis existe, vérifiez la correspondance des informations.',
              ),
              _buildHelpSection(
                icon: Icons.check_circle,
                title: 'Marquer comme reçu',
                description: 'Une fois la correspondance vérifiée, marquez le colis comme reçu dans le système.',
              ),
              _buildHelpSection(
                icon: Icons.list,
                title: 'Gestion des commandes',
                description: 'Dans la rubrique "Commandes", suivez l\'état de réception de tous les colis associés à une commande.',
              ),
              _buildHelpSection(
                icon: Icons.local_shipping,
                title: 'Expédition',
                description: 'Lorsque tous les colis d\'une commande sont marqués comme reçus et que l\'heure d\'expédition est arrivée, changez le statut de la commande pour la marquer comme envoyée.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue.shade800, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}