
import 'package:flutter/material.dart';

void main() {
  runApp(const FasoOneApp());
}

class FasoOneApp extends StatelessWidget {
  const FasoOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FASO ONE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087443),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String langue = 'Français';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const Icon(
                    Icons.account_balance,
                    size: 85,
                    color: Color(0xFF087443),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'FASO ONE',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF087443),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Vos services publics, plus accessibles.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 35),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choisissez votre langue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: langue,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Français',
                        child: Text('Français'),
                      ),
                      DropdownMenuItem(
                        value: 'Mooré',
                        child: Text('Mooré'),
                      ),
                      DropdownMenuItem(
                        value: 'Dioula',
                        child: Text('Dioula'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => langue = value);
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF087443),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServicesPage(
                              langue: langue,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Commencer',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Une porte d’entrée vers les services publics.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  final String langue;

  const ServicesPage({
    super.key,
    required this.langue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      appBar: AppBar(
        title: const Text('FASO ONE'),
        backgroundColor: const Color(0xFF087443),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choisir une démarche',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Langue sélectionnée : $langue'),
                const SizedBox(height: 24),
                ServiceCard(
                  icon: Icons.child_care,
                  title: 'Extrait d’acte de naissance',
                  description: 'Démarche de démonstration',
                ),
                ServiceCard(
                  icon: Icons.gavel,
                  title: 'Casier judiciaire',
                  description: 'Démarche de démonstration',
                ),
                ServiceCard(
                  icon: Icons.verified_user,
                  title: 'Certificat de nationalité',
                  description: 'Démarche de démonstration',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          icon,
          size: 35,
          color: const Color(0xFF087443),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RequestFormPage(service: title),
    ),
  );
},

      ),
    );
  }
}

class RequestFormPage extends StatefulWidget {
  final String service;

  const RequestFormPage({
    super.key,
    required this.service,
  });

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool submitted = false;
  String reference = '';

  void submitRequest() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      reference =
          'FASO-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}';
      submitted = true;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F7),
      appBar: AppBar(
        title: const Text('Nouvelle demande'),
        backgroundColor: const Color(0xFF087443),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: submitted
                ? Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF087443),
                        size: 80,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Demande enregistrée pour la démonstration !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text('Votre référence de démonstration :'),
                      const SizedBox(height: 10),
                      SelectableText(
                        reference,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF087443),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Cette référence est générée localement. '
                        'La demande n’a pas encore été transmise '
                        'à une administration.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                        },
                        child: const Text('Retour à l’accueil'),
                      ),
                    ],
                  )
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Formulaire de démonstration',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Démarche : ${widget.service}'),
                        const SizedBox(height: 25),
                        const Text('Nom du demandeur (fictif)'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Exemple : Utilisateur Démo',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Veuillez saisir un nom fictif';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text('Description de la demande'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Décrivez votre demande...',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Veuillez saisir une description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF087443),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: submitRequest,
                            child: const Text(
                              'Envoyer la demande de démonstration',
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'N’utilisez aucune vraie donnée personnelle. '
                          'Ce formulaire est uniquement destiné au prototype.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

