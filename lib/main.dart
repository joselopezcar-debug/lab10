import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

// -----------------------------------------------------------------------------
// TEMA GLOBAL Y RUTAS (Capacidad: Tema Global y Rutas)
// -----------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix Clone Lab',
      debugShowCheckedModeBanner: false,
      
      // Tema Global de la aplicación
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141414),
        primaryColor: const Color(0xFFE50914),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          surface: Color(0xFF1F1F1F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),

      // Definición de Rutas
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(),
      },
    );
  }
}

// -----------------------------------------------------------------------------
// ESTRUCTURA DE DATOS (Capacidad: Listas y Mapas)
// -----------------------------------------------------------------------------
final mockCategories = [
  {
    'categoryName': 'Populares en Netflix',
    'items': [
      {
        'title': 'Stranger Things',
        'isLocal': false,
        'imageUrl': 'https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?q=80&w=600&auto=format&fit=crop',
        'year': '2022',
        'rating': 'TV-MA',
        'description': 'Cuando un niño desaparece, sus amigos, la familia y la policía se ven envueltos en un misterio desgarrador.',
      },
      {
        'title': 'Contenido Local (Offline)',
        'isLocal': true,
        'imageUrl': 'assets/images/logo.png', // Imagen Local
        'year': '2024',
        'rating': 'TV-14',
        'description': 'Demostración de renderizado de imagen almacenada en assets locales.',
      },
      {
        'title': 'Cyber Odyssey',
        'isLocal': false,
        'imageUrl': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?q=80&w=600&auto=format&fit=crop',
        'year': '2023',
        'rating': 'TV-MA',
        'description': 'Un thriller futurista en una metrópolis dominada por la realidad virtual.',
      },
    ],
  },
  {
    'categoryName': 'Tendencias Ahora',
    'items': [
      {
        'title': 'Dark Cosmos',
        'isLocal': false,
        'imageUrl': 'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?q=80&w=600&auto=format&fit=crop',
        'year': '2021',
        'rating': 'TV-14',
        'description': 'Una expedición hacia lo desconocido desafía las leyes del espacio y el tiempo.',
      },
      {
        'title': 'Neon Horizon',
        'isLocal': false,
        'imageUrl': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop',
        'year': '2024',
        'rating': 'PG-13',
        'description': 'Aventuras urbanas bajo luces de neón y carreras nocturnas.',
      },
    ],
  },
];

// -----------------------------------------------------------------------------
// PANTALLA PRINCIPAL (ListView, Cards, Rows, Column, 3 Fuentes, Imágenes)
// -----------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NETFLIX',
          // TIPO DE LETRA 1: GoogleFonts.bebasNeue (Titulares y Marca)
          style: GoogleFonts.bebasNeue(
            color: const Color(0xFFE50914),
            fontSize: 32,
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      // ListView Principal (Scroll Vertical)
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // BANNER PRINCIPAL (Column & Row)
          _buildHeroBanner(context),

          const SizedBox(height: 20),

          // LISTAS HORIZONTALES POR CATEGORÍA
          ...mockCategories.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    category['categoryName'].toString(),
                    // TIPO DE LETRA 2: GoogleFonts.montserrat (Subtítulos de Sección)
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // ListView Horizontal dentro de un Container con altura fija
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (category['items'] as List).length,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    itemBuilder: (context, index) {
                      final item = (category['items'] as List)[index];
                      return _buildMovieCard(context, item);
                    },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          }),
        ],
      ),
    );
  }

  // Componente Hero Banner usando Column, Row e Imágenes en la Nube
  Widget _buildHeroBanner(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Imagen en la Nube
        Image.network(
          'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1000&auto=format&fit=crop',
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 350,
            color: Colors.grey[900],
            child: const Center(child: Icon(Icons.movie, size: 50, color: Colors.grey)),
          ),
        ),
        // Degradado oscuro sobre el banner
        Container(
          height: 350,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87, Color(0xFF141414)],
            ),
          ),
        ),
        // Contenido sobre la imagen en Row y Column
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'DESTACADO HOY',
                // TIPO DE LETRA 1
                style: GoogleFonts.bebasNeue(
                  fontSize: 36,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: Text(
                      'Reproducir',
                      // TIPO DE LETRA 3: GoogleFonts.lato (Texto Secundario/Botones)
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: Text(
                      'Mi Lista',
                      style: GoogleFonts.lato(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Componente Card para cada Película
  Widget _buildMovieCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        // Navegación por Rutas pasando argumentos
        Navigator.pushNamed(context, '/detail', arguments: item);
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Card( // Capacidad: Card
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color(0xFF262626),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: item['isLocal']
                    // Capacidad: Imagen Local (AssetImage)
                    ? Image.asset(
                        item['imageUrl'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[800],
                          child: const Icon(Icons.image, color: Colors.white),
                        ),
                      )
                    // Capacidad: Imagen en la Nube (NetworkImage)
                    : Image.network(
                        item['imageUrl'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[800],
                          child: const Icon(Icons.broken_image, color: Colors.white54),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  item['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  // TIPO DE LETRA 3: GoogleFonts.lato
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PANTALLA DE DETALLE (ListTiles, Column, Row, Rutas)
// -----------------------------------------------------------------------------
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recepción de argumentos enviados por la Ruta
    final Map<String, dynamic> movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie['title'],
          // TIPO DE LETRA 2: GoogleFonts.montserrat
          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          // Imagen Portada principal de la película
          SizedBox(
            height: 220,
            width: double.infinity,
            child: movie['isLocal']
                ? Image.asset(movie['imageUrl'], fit: BoxFit.cover)
                : Image.network(movie['imageUrl'], fit: BoxFit.cover),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título Principal
                Text(
                  movie['title'],
                  // TIPO DE LETRA 1: GoogleFonts.bebasNeue
                  style: GoogleFonts.bebasNeue(
                    fontSize: 34,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 8),

                // Fila (Row) de Metadatos
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        movie['rating'],
                        // TIPO DE LETRA 3: GoogleFonts.lato
                        style: GoogleFonts.lato(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      movie['year'],
                      style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.hd, size: 18, color: Colors.grey),
                  ],
                ),

                const SizedBox(height: 16),

                // Descripción
                Text(
                  movie['description'],
                  // TIPO DE LETRA 3: GoogleFonts.lato
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 24),
                const Divider(color: Colors.white24),
                const SizedBox(height: 10),

                // Opciones y Controles usando ListTiles (Capacidad: ListTiles)
                Text(
                  'OPCIONES Y CONFIGURACIÓN',
                  // TIPO DE LETRA 2: GoogleFonts.montserrat
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),

                ListTile( // ListTile 1
                  leading: const Icon(Icons.download_for_offline, color: Color(0xFFE50914)),
                  title: Text(
                    'Descargar Episodio 1',
                    style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'HD (1080p) - 450 MB',
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                ListTile( // ListTile 2
                  leading: const Icon(Icons.subtitles, color: Colors.white),
                  title: Text(
                    'Audio y Subtítulos',
                    style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Español (Latino), Inglés [Original]',
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),

                ListTile( // ListTile 3
                  leading: const Icon(Icons.share, color: Colors.white),
                  title: Text(
                    'Compartir título',
                    style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Envía este contenido a tus amigos',
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}