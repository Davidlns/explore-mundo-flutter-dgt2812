import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Mundo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        useMaterial3: true,
      ),
      home: const ExploreMundoPage(),
    );
  }
}

class ExploreMundoPage extends StatefulWidget {
  const ExploreMundoPage({super.key});

  @override
  State<ExploreMundoPage> createState() => _ExploreMundoPageState();
}

class _ExploreMundoPageState extends State<ExploreMundoPage> {
  static const List<BannerHighlight> _banners = [
    BannerHighlight(
      title: 'Explore Mundo',
      subtitle: 'Descubra destinos alpinos, pacotes especiais e experiencias inesqueciveis.',
      actionLabel: 'Ver pacotes',
    ),
    BannerHighlight(
      title: 'Pacotes com avaliacao real',
      subtitle: 'Veja opinioes dos clientes, compare estrelas e escolha sua proxima viagem.',
      actionLabel: 'Ler avaliacoes',
    ),
    BannerHighlight(
      title: 'Atendimento rapido',
      subtitle: 'Pesquise destinos, filtre ofertas e fale com a equipe da agencia em poucos cliques.',
      actionLabel: 'Falar com a equipe',
    ),
  ];

  static const List<DestinationSpot> _destinations = [
    DestinationSpot(
      name: 'Kandersteg',
      country: 'Suica',
      description: 'Paisagens alpinas, trilhas panoramicas e clima ideal para experiencias ao ar livre.',
      rating: 4.9,
    ),
    DestinationSpot(
      name: 'Lucerna',
      country: 'Suica',
      description: 'Cidade charmosa com lago, centro historico e acesso facilitado a roteiros culturais.',
      rating: 4.8,
    ),
    DestinationSpot(
      name: 'Innsbruck',
      country: 'Austria',
      description: 'Montanhas, arquitetura e esportes de inverno em um unico destino.',
      rating: 4.7,
    ),
  ];

  static const List<TravelPackage> _packages = [
    TravelPackage(
      title: 'Pacote Alpes Nevados',
      destination: 'Kandersteg',
      duration: '5 dias',
      price: 'R\$ 4.590',
      rating: 4.9,
      summary: 'Hospedagem, passeio panoramico e roteiro guiado pela regiao alpina.',
    ),
    TravelPackage(
      title: 'Circuito Lagos da Suica',
      destination: 'Lucerna',
      duration: '7 dias',
      price: 'R\$ 5.290',
      rating: 4.8,
      summary: 'Passeios de barco, visita cultural e hospedagem central com cafe da manha.',
    ),
    TravelPackage(
      title: 'Aventura nos Alpes Austriacos',
      destination: 'Innsbruck',
      duration: '6 dias',
      price: 'R\$ 4.980',
      rating: 4.7,
      summary: 'Experiencia com mirantes, transporte local e roteiro flexivel para o grupo.',
    ),
    TravelPackage(
      title: 'Weekend Premium',
      destination: 'Kandersteg',
      duration: '3 dias',
      price: 'R\$ 2.890',
      rating: 4.6,
      summary: 'Viagem curta com foco em descanso, gastronomia local e visual de montanha.',
    ),
  ];

  final GlobalKey _destinationsKey = GlobalKey();
  final GlobalKey _packagesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  late final PageController _pageController;

  late List<ReviewEntry> _reviews;
  String _selectedDestination = 'Todos';
  int _selectedRating = 5;
  int _currentBanner = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _reviews = <ReviewEntry>[
      const ReviewEntry(
        author: 'Marina',
        destination: 'Kandersteg',
        rating: 5,
        comment: 'Atendimento excelente e roteiro muito bem organizado.',
      ),
      const ReviewEntry(
        author: 'Carlos',
        destination: 'Lucerna',
        rating: 4,
        comment: 'A plataforma ajudou a comparar opcoes e decidir rapidamente.',
      ),
      const ReviewEntry(
        author: 'Fernanda',
        destination: 'Innsbruck',
        rating: 5,
        comment: 'Gostei da clareza das informacoes e das avaliacoes visiveis.',
      ),
    ];
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  List<TravelPackage> get _filteredPackages {
    final String query = _searchController.text.trim().toLowerCase();
    return _packages.where((TravelPackage package) {
      final bool destinationMatches = _selectedDestination == 'Todos' ||
          package.destination == _selectedDestination;
      final bool queryMatches = query.isEmpty ||
          package.title.toLowerCase().contains(query) ||
          package.destination.toLowerCase().contains(query) ||
          package.summary.toLowerCase().contains(query);
      return destinationMatches && queryMatches;
    }).toList();
  }

  double get _averageRating {
    if (_reviews.isEmpty) {
      return 0;
    }
    final int total = _reviews.fold<int>(
      0,
      (int sum, ReviewEntry entry) => sum + entry.rating,
    );
    return total / _reviews.length;
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final BuildContext? context = key.currentContext;
    if (context == null) {
      return;
    }
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  void _handleBannerAction() {
    if (_currentBanner == 0) {
      _scrollTo(_packagesKey);
    } else if (_currentBanner == 1) {
      _scrollTo(_reviewsKey);
    } else {
      _scrollTo(_contactKey);
    }
  }

  void _selectDestination(String destination) {
    setState(() {
      _selectedDestination = destination;
    });
    _scrollTo(_packagesKey);
  }

  void _reservePackage(TravelPackage package) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reserva iniciada para ${package.title}.'),
      ),
    );
  }

  void _submitComment() {
    final String text = _commentController.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _reviews = <ReviewEntry>[
        ReviewEntry(
          author: 'Visitante',
          destination: _selectedDestination == 'Todos'
              ? _filteredPackages.isNotEmpty
                  ? _filteredPackages.first.destination
                  : 'Kandersteg'
              : _selectedDestination,
          rating: _selectedRating,
          comment: text,
        ),
        ..._reviews,
      ];
      _commentController.clear();
      _selectedRating = 5;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comentario enviado com sucesso.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final bool isMobile = width < 760;
        final bool isTablet = width >= 760 && width < 1120;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Explore Mundo'),
            actions: isMobile
                ? <Widget>[
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        switch (value) {
                          case 'destinos':
                            _scrollTo(_destinationsKey);
                            break;
                          case 'pacotes':
                            _scrollTo(_packagesKey);
                            break;
                          case 'avaliacoes':
                            _scrollTo(_reviewsKey);
                            break;
                          case 'contato':
                            _scrollTo(_contactKey);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          const <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'destinos',
                          child: Text('Destinos'),
                        ),
                        PopupMenuItem<String>(
                          value: 'pacotes',
                          child: Text('Pacotes'),
                        ),
                        PopupMenuItem<String>(
                          value: 'avaliacoes',
                          child: Text('Avaliacoes'),
                        ),
                        PopupMenuItem<String>(
                          value: 'contato',
                          child: Text('Contato'),
                        ),
                      ],
                    ),
                  ]
                : <Widget>[
                    TextButton(
                      onPressed: () => _scrollTo(_destinationsKey),
                      child: const Text('Destinos'),
                    ),
                    TextButton(
                      onPressed: () => _scrollTo(_packagesKey),
                      child: const Text('Pacotes'),
                    ),
                    TextButton(
                      onPressed: () => _scrollTo(_reviewsKey),
                      child: const Text('Avaliacoes'),
                    ),
                    TextButton(
                      onPressed: () => _scrollTo(_contactKey),
                      child: const Text('Contato'),
                    ),
                    const SizedBox(width: 12),
                  ],
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildHeroSection(context, isMobile, isTablet),
              _buildStatsSection(context, isMobile, isTablet),
              _buildDestinationsSection(context, isMobile, isTablet),
              _buildPackagesSection(context, isMobile, isTablet),
              _buildReviewsSection(context, isMobile, isTablet),
              _buildContactSection(context, isMobile, isTablet),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _scrollTo(_reviewsKey),
            icon: const Icon(Icons.rate_review_outlined),
            label: const Text('Avaliar'),
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile, bool isTablet) {
    final double heroHeight = isMobile ? 420 : 520;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, isMobile ? 20 : 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Color(0xFF0F766E), Color(0xFF115E59)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: heroHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _banners.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentBanner = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                final BannerHighlight banner = _banners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(
                          'images/lake.jpg',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.black.withValues(alpha: 0.15),
                                Colors.black.withValues(alpha: 0.65),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(isMobile ? 20 : 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.14),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Text(
                                  'Experiencia responsiva para mobile, tablet e desktop',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                banner.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 620),
                                child: Text(
                                  banner.subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: <Widget>[
                                  FilledButton.icon(
                                    onPressed: _handleBannerAction,
                                    icon: const Icon(Icons.touch_app),
                                    label: Text(banner.actionLabel),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: () => _scrollTo(_reviewsKey),
                                    icon: const Icon(Icons.star_outline),
                                    label: const Text('Compartilhar opiniao'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      side: const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: List<Widget>.generate(_banners.length, (int index) {
              final bool selected = index == _currentBanner;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 10,
                width: selected ? 28 : 10,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, bool isMobile, bool isTablet) {
    final List<_StatItem> stats = <_StatItem>[
      _StatItem(
        title: 'Avaliacao media',
        value: _averageRating.toStringAsFixed(1),
        icon: Icons.star_rounded,
      ),
      _StatItem(
        title: 'Pacotes ativos',
        value: _packages.length.toString(),
        icon: Icons.card_travel,
      ),
      _StatItem(
        title: 'Comentarios',
        value: _reviews.length.toString(),
        icon: Icons.chat_bubble_outline,
      ),
    ];

    final int columns = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stats.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: isMobile ? 3.1 : 2.4,
        ),
        itemBuilder: (BuildContext context, int index) {
          final _StatItem stat = stats[index];
          return Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: ListTile(
              leading: Icon(stat.icon),
              title: Text(
                stat.value,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              subtitle: Text(stat.title),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDestinationsSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    final int columns = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      key: _destinationsKey,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Destinos em destaque',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Escolha um destino para filtrar os pacotes e navegar pela aplicacao.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              ChoiceChip(
                label: const Text('Todos'),
                selected: _selectedDestination == 'Todos',
                onSelected: (_) => _selectDestination('Todos'),
              ),
              ..._destinations.map(
                (DestinationSpot destination) => ChoiceChip(
                  label: Text(destination.name),
                  selected: _selectedDestination == destination.name,
                  onSelected: (_) => _selectDestination(destination.name),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _destinations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.15 : 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final DestinationSpot destination = _destinations[index];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.landscape_outlined),
                          const Spacer(),
                          Icon(Icons.star, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(destination.rating.toStringAsFixed(1)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        destination.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(destination.country),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          destination.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilledButton.tonalIcon(
                        onPressed: () => _selectDestination(destination.name),
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Ver pacotes'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    final List<TravelPackage> filteredPackages = _filteredPackages;
    final int columns = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      key: _packagesKey,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pacotes de viagem',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Pesquise um destino ou compare pacotes por nome e descricao.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Pesquisar destino ou pacote',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '${filteredPackages.length} pacote(s) encontrado(s)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredPackages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.0 : 0.92,
            ),
            itemBuilder: (BuildContext context, int index) {
              final TravelPackage package = filteredPackages[index];
              return Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Chip(label: Text(package.destination)),
                          const Spacer(),
                          Icon(Icons.star, color: Colors.amber[700], size: 20),
                          const SizedBox(width: 4),
                          Text(package.rating.toStringAsFixed(1)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        package.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(package.summary),
                      const SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.schedule_outlined, size: 18),
                          const SizedBox(width: 6),
                          Text(package.duration),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.payments_outlined, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            package.price,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _scrollTo(_reviewsKey),
                              child: const Text('Ver avaliacoes'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: () => _reservePackage(package),
                              child: const Text('Reservar'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    final Widget summaryCard = Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Avaliacao dos clientes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  _averageRating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    children: List<Widget>.generate(
                      5,
                      (int index) => Icon(
                        index < _averageRating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${_reviews.length} comentario(s) compartilhado(s) na plataforma.',
            ),
          ],
        ),
      ),
    );

    final Widget composerCard = Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Compartilhe sua experiencia',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _selectedRating,
              decoration: const InputDecoration(
                labelText: 'Nota',
                border: OutlineInputBorder(),
              ),
              items: List<DropdownMenuItem<int>>.generate(
                5,
                (int index) {
                  final int value = index + 1;
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value estrela(s)'),
                  );
                },
              ),
              onChanged: (int? value) {
                setState(() {
                  _selectedRating = value ?? 5;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Comentario',
                hintText: 'Conte como foi sua experiencia com o destino ou pacote.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: _submitComment,
                icon: const Icon(Icons.send),
                label: const Text('Enviar comentario'),
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      key: _reviewsKey,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Avaliacoes e comentarios',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Widgets interativos permitem registrar opinioes e visualizar a satisfacao dos clientes.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          if (isMobile)
            Column(
              children: <Widget>[
                summaryCard,
                const SizedBox(height: 16),
                composerCard,
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: summaryCard),
                const SizedBox(width: 16),
                Expanded(child: composerCard),
              ],
            ),
          const SizedBox(height: 18),
          ..._reviews.map(
            (ReviewEntry review) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(18),
                leading: CircleAvatar(
                  child: Text(review.author.substring(0, 1)),
                ),
                title: Text('${review.author} - ${review.destination}'),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(review.comment),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.amber[700]),
                    Text(review.rating.toString()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Padding(
      key: _contactKey,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Contato da agencia',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                'Entre em contato para receber uma proposta personalizada e tirar duvidas sobre reservas.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 18),
              const Wrap(
                spacing: 20,
                runSpacing: 12,
                children: <Widget>[
                  _ContactInfo(icon: Icons.mail_outline, text: 'contato@exploremundo.com'),
                  _ContactInfo(icon: Icons.phone_outlined, text: '+55 (31) 99999-0000'),
                  _ContactInfo(icon: Icons.location_on_outlined, text: 'Atendimento online e presencial'),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  FilledButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Equipe acionada para atendimento inicial.'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.support_agent),
                    label: const Text('Falar com a equipe'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _scrollTo(_packagesKey),
                    icon: const Icon(Icons.explore_outlined),
                    label: const Text('Explorar pacotes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

class _StatItem {
  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;
}

class BannerHighlight {
  const BannerHighlight({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
}

class DestinationSpot {
  const DestinationSpot({
    required this.name,
    required this.country,
    required this.description,
    required this.rating,
  });

  final String name;
  final String country;
  final String description;
  final double rating;
}

class TravelPackage {
  const TravelPackage({
    required this.title,
    required this.destination,
    required this.duration,
    required this.price,
    required this.rating,
    required this.summary,
  });

  final String title;
  final String destination;
  final String duration;
  final String price;
  final double rating;
  final String summary;
}

class ReviewEntry {
  const ReviewEntry({
    required this.author,
    required this.destination,
    required this.rating,
    required this.comment,
  });

  final String author;
  final String destination;
  final int rating;
  final String comment;
}
