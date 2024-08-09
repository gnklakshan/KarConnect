import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int selectedDeveloperIndex = 0;

  final List<Developer> developers = [
    Developer(
      name: "G.N.K Lakshan",
      role: "Undergraduate",
      image: 'assets/images/profile.jpg',
      description:
          "Full-stack development, project management, and system architecture.",
    ),
    Developer(
      name: "H.S.V Peries",
      role: "Undergraduate",
      image: 'assets/images/profile.jpg',
      description:
          "UI/UX design, React, Flutter, and user interface implementation.",
    ),
    Developer(
      name: "M.A Hettiarachchi",
      role: "Undergraduate",
      image: 'assets/images/profile.jpg',
      description:
          "UI/UX design, React, Flutter, and user interface implementation.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logos/teamlogo.png'),
              // const Text(
              //   "Introduction",
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              // // const SizedBox(height: 16),
              const Text(
                "We are Nitro Runners, a dedicated team of three developers currently in our third year of undergraduate studies. Our diverse skills and collaborative approach enable us to tackle complex challenges and deliver high-quality products. Each member of our team brings unique strengths and perspectives, allowing us to innovate and create effective solutions that meet the needs of our clients and users. Our commitment to excellence and continuous learning drives us to stay at the forefront of technology and industry trends, ensuring that we deliver top-notch results in every project we undertake.",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),

              // const ExpandableText(
              //   "We are Nitro Runners, a dedicated team of three developers currently in our third year of undergraduate studies. Our diverse skills and collaborative approach enable us to tackle complex challenges and deliver high-quality products. Each member of our team brings unique strengths and perspectives, allowing us to innovate and create effective solutions that meet the needs of our clients and users. Our commitment to excellence and continuous learning drives us to stay at the forefront of technology and industry trends, ensuring that we deliver top-notch results in every project we undertake.",
              //   expandText: 'Read More',
              //   collapseText: 'Read Less',
              //   maxLines: 4,
              //   linkColor: Colors.blue,
              //   style: TextStyle(fontSize: 16),
              // ),
              // const SizedBox(height: 16),
              // const Text(
              //   "Mission",
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // const ExpandableText(
              //   "Our mission is to create innovative and user-friendly applications that solve real-world problems and enhance user experiences. We strive to stay at the forefront of technology and industry trends, ensuring that our solutions are not only effective but also future-proof.",
              //   expandText: 'Read More',
              //   collapseText: 'Read Less',
              //   maxLines: 4,
              //   linkColor: Colors.blue,
              //   style: TextStyle(fontSize: 16),
              // ),
              const SizedBox(height: 24),
              const Text(
                "Meet the Developers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: developers.length,
                  itemBuilder: (context, index) => _buildDeveloperAvatar(index),
                ),
              ),
              const SizedBox(height: 24),
              _buildDeveloperDetails(developers[selectedDeveloperIndex]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperAvatar(int index) {
    bool isSelected = selectedDeveloperIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDeveloperIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(214, 204, 108, 230)
                : const Color.fromRGBO(0, 0, 0, 0),
            width: 3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: const Color.fromARGB(255, 222, 33, 243)
                          .withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2)
                ]
              : [],
        ),
        child: CircleAvatar(
          radius: isSelected ? 45 : 40,
          backgroundImage: AssetImage(developers[index].image),
        ),
      ),
    );
  }

  Widget _buildDeveloperDetails(Developer developer) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        key: ValueKey(developer.name),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            developer.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            developer.role,
            style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 113, 112, 124)),
          ),
          const SizedBox(height: 16),
          Text(
            developer.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class Developer {
  final String name;
  final String role;
  final String image;
  final String description;

  Developer({
    required this.name,
    required this.role,
    required this.image,
    required this.description,
  });
}
