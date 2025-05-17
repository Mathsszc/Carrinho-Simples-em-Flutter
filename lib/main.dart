import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mercado",
      home: CardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Produto {
  final String nome;
  final double price;
  final String image;

  Produto({required this.nome, required this.price, required this.image});
}

List<Produto> produtosDisponiveis = [
  Produto(nome: "Camiseta", price: 49.90, image: "assets/Camiseta.webp"),
  Produto(nome: "Tênis", price: 199.90, image: "assets/tenis.webp"),
  Produto(nome: "Mochila", price: 129.90, image: "assets/mochila.webp"),
];

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<Produto> carrinho = [];

  void adicionarAoCarrinho(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  double calcularTotal() {
    return carrinho.fold(0, (total, produto) => total + produto.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 85, 212),
        title: Text("Mercado"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Define 2 colunas na grade
                  crossAxisSpacing: 10, // Espaçamento horizontal
                  mainAxisSpacing: 10, // Espaçamento vertical
                  childAspectRatio: 0.8, // Proporção ajustada dos itens
                ),
                itemCount: produtosDisponiveis.length,
                itemBuilder: (context, index) {
                  Produto produto = produtosDisponiveis[index];
                  return Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(produto.image, width: 80, height: 80),
                        SizedBox(height: 8),
                        Text(produto.nome, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("R\$ ${produto.price.toStringAsFixed(2)}"),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            adicionarAoCarrinho(produto);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
            width: double.infinity,
            child: Text(
              "Total do Carrinho: R\$ ${calcularTotal().toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
