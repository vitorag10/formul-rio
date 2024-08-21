import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueAccent),
      ),
      home: OperadorPage(),
    );
  }
}

class OperadorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300], // Cabeçalho em cinza
        title: Center(
          child: Text(
            '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Texto do cabeçalho em branco
            ),
          ),
        ),
      ),
      body: SingleChildScrollView( // Adicionado para permitir rolagem
        child: Container(
          color: Colors.grey[300], // Fundo da página em cinza
          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logogdf.png', // Certifique-se de que o caminho esteja correto
                    width: 210, // Ajuste a largura conforme necessário
                    height: 110, // Ajuste a altura conforme necessário
                  ),
                  SizedBox(width: 8), // Espaço entre a imagem e o texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SECRETARIA DE TRANSPORTE E MOBILIDADE',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'Open Sans',
                            overflow: TextOverflow.ellipsis, // Evita overflow do texto
                          ),
                          maxLines: 1, // Limita o texto a uma linha
                        ),
                        SizedBox(height: 0),
                        Text(
                          'SEMOB',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16), // Aumente este valor para aumentar a distância
              Container(
                width: double.infinity, // Ajuste o comprimento aqui para se adaptar ao conteúdo
                color: Color(0xFF005EB8), // Azul do GDF
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Formulário de Cadastro de Operador',
                  textAlign: TextAlign.center, // Centraliza o texto
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white, // Texto em branco para contraste
                  ),
                ),
              ),
              Container(
                width: double.infinity, // Ocupa toda a largura disponível
                color: Colors.white, // Fundo do formulário em branco
                padding: EdgeInsets.all(24.0), // Adiciona um padding interno
                child: MyForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String _selectedTipoOperadora = 'Pessoa Jurídica';
  TextEditingController _dateController = TextEditingController();
  TextEditingController _expedicaoController = TextEditingController();
  TextEditingController _validadeController = TextEditingController();

  final List<String> ufs = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

  final List<String> sexos = ['Masculino', 'Feminino', 'Não Informar'];
  final List<String> cores = ['Branco', 'Preto', 'Pardo', 'Amarelo', 'Indígena'];
  final List<String> etnias = ['Europeu', 'Africano', 'Asiático', 'Ameríndio', 'Mestiço'];
  final List<String> categoriasCNH = ['A', 'B', 'C', 'D', 'E'];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true, // Permite que o ListView ocupe apenas o espaço necessário
      children: [
        IdentificationSection(),
        SizedBox(height: 24),
        AddressSection(),
        SizedBox(height: 24),
        ContactsSection(),
        SizedBox(height: 24),
        IssSection(
          dateController: _dateController,
        ),
        SizedBox(height: 24),
        Text(
          'Tipo da Operadora',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RadioListTile(
                value: 'Pessoa Jurídica',
                groupValue: _selectedTipoOperadora,
                onChanged: (value) {
                  setState(() {
                    _selectedTipoOperadora = value.toString();
                  });
                },
                title: Text('Pessoa Jurídica'),
              ),
            ),
            Expanded(
              child: RadioListTile(
                value: 'Pessoa Física',
                groupValue: _selectedTipoOperadora,
                onChanged: (value) {
                  setState(() {
                    _selectedTipoOperadora = value.toString();
                  });
                },
                title: Text('Pessoa Física'),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        if (_selectedTipoOperadora == 'Pessoa Física')
          PessoaFisicaForm(
            ufs: ufs,
            sexos: sexos,
            cores: cores,
            etnias: etnias,
            categoriasCNH: categoriasCNH,
            expedicaoController: _expedicaoController,
            validadeController: _validadeController,
          )
        else if (_selectedTipoOperadora == 'Pessoa Jurídica')
          PessoaJuridicaForm(
            ufs: ufs,
          ),
        SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navegação removida
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.check),
              label: Text("Cadastrar"),
            ),
          ),
        ),
      ],
    );
  }
}


class PessoaFisicaForm extends StatefulWidget {
  final List<String> ufs;
  final List<String> sexos;
  final List<String> cores;
  final List<String> etnias;
  final List<String> categoriasCNH;
  final TextEditingController expedicaoController;
  final TextEditingController validadeController;

  PessoaFisicaForm({
    required this.ufs,
    required this.sexos,
    required this.cores,
    required this.etnias,
    required this.categoriasCNH,
    required this.expedicaoController,
    required this.validadeController,
  });

  @override
  _PessoaFisicaFormState createState() => _PessoaFisicaFormState();
}

class _PessoaFisicaFormState extends State<PessoaFisicaForm> {
  String? selectedDocumentacaoUF;
  String? selectedReservistaUF;
  String? selectedCNHUF;
  String? selectedNascimentoUF;
  String? selectedSexo;
  String? selectedCor;
  String? selectedEtinia;
  String? selectedCategoria;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 24),
            SizedBox(width: 8),
            Text('Dados Pessoa Física', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'Nome Completo')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Telefone Celular')),
            SizedBox(width: 16),
            Expanded(
              child: CustomDropdownField(
                label: 'Sexo',
                value: selectedSexo,
                items: widget.sexos,
                onChanged: (value) {
                  setState(() {
                    selectedSexo = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomDropdownField(
                label: 'Cor',
                value: selectedCor,
                items: widget.cores,
                onChanged: (value) {
                  setState(() {
                    selectedCor = value;
                  });
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomDropdownField(
                label: 'Etinia',
                value: selectedEtinia,
                items: widget.etnias,
                onChanged: (value) {
                  setState(() {
                    selectedEtinia = value;
                  });
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Raça')),
          ],
        ),
        SizedBox(height: 12), // Adicionando um espaço de 24 pixels
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'Data de Nascimento')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Naturalidade')),
            SizedBox(width: 16),
            Expanded(
              child: CustomDropdownField(
                label: 'UF Nascimento',
                value: selectedNascimentoUF,
                items: widget.ufs,
                onChanged: (newValue) {
                  setState(() {
                    selectedNascimentoUF = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 24), // Adicionando um espaço de 24 pixels
        Row(
          children: [
            Icon(Icons.family_restroom, size: 24),
            SizedBox(width: 8), // Espaço entre o ícone e o texto
            Text('Filiação', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'Nome da Mãe')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Nome do Pai')),
          ],
        ),
        SizedBox(height: 24), // Adicionando um espaço de 24 pixels
        Row(
          children: [
            Icon(Icons.assignment, size: 24),
            SizedBox(width: 8), // Espaço entre o ícone e o texto
            Text('Documentação', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'CPF')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Número Identidade')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Órgão Exp.')),
            SizedBox(width: 16),
            Expanded(
              child: CustomDropdownField(
                label: 'UF Documentação',
                value: selectedDocumentacaoUF,
                items: widget.ufs,
                onChanged: (newValue) {
                  setState(() {
                    selectedDocumentacaoUF = newValue;
                  });
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTextField(label: 'Data de Expedição', controller: widget.expedicaoController),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.shield, size: 24),
            SizedBox(width: 8),
            Text('Certificado de Reservista', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'Número')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Região')),
            SizedBox(width: 16),
            Expanded(
              child: CustomDropdownField(
                label: 'UF Reservista',
                value: selectedReservistaUF,
                items: widget.ufs,
                onChanged: (newValue) {
                  setState(() {
                    selectedReservistaUF = newValue;
                  });
                },
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.card_membership, size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Carteira Nacional de Habilitação',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 16), // Espaço entre a linha do título e os campos
            Row(
              children: [
                Expanded(child: CustomTextField(label: 'Nr. Registro')),
                SizedBox(width: 16),
                Expanded(
                  child: CustomDropdownField(
                    label: 'Categoria',
                    value: selectedCategoria,
                    items: widget.categoriasCNH,
                    onChanged: (value) {
                      setState(() {
                        selectedCategoria = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(child: CustomTextField(label: 'Órgão Exp.')),
              ],
            ),
            SizedBox(height: 12), // Espaço entre a linha de campos e a linha abaixo
            Row(
              children: [
                Expanded(
                  child: CustomDropdownField(
                    label: 'UF CNH',
                    value: selectedCNHUF,
                    items: widget.ufs,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCNHUF = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Data de Expedição',
                    controller: widget.expedicaoController,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Validade',
                    controller: widget.validadeController,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class PessoaJuridicaForm extends StatefulWidget {
  final List<String> ufs;

  PessoaJuridicaForm({required this.ufs});

  @override
  _PessoaJuridicaFormState createState() => _PessoaJuridicaFormState();
}

class _PessoaJuridicaFormState extends State<PessoaJuridicaForm> {
  String? selectedJuridicaUF;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.business, size: 24),
            SizedBox(width: 8),
            Text('Dados Pessoa Jurídica', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'Razão Social')),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'CNPJ')),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: CustomTextField(label: 'Inscrição Estadual')),
            SizedBox(width: 16),
            Expanded(
              child: CustomDropdownField(
                label: 'UF',
                value: selectedJuridicaUF,
                items: widget.ufs,
                onChanged: (newValue) {
                  setState(() {
                    selectedJuridicaUF = newValue;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IdentificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.business, size: 24),
            SizedBox(width: 8),
            Text('Identificação Empresa', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Sigla'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Nº de Inscrição no DMTU'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Cód. Operadora SBA'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Grupo Econômico'))),
          ],
        ),
      ],
    );
  }
}

class AddressSection extends StatefulWidget {
  @override
  _AddressSectionState createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  String? selectedEnderecoUF;

  final List<String> ufs = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.home, size: 24),
            SizedBox(width: 8),
            Text('Endereço', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Endereço'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Cidade'))),
            SizedBox(width: 16),
            Expanded(
              child: SizedBox(width: 100, child: CustomDropdownField(
                label: 'UF',
                value: selectedEnderecoUF,
                items: ufs,
                onChanged: (newValue) {
                  setState(() {
                    selectedEnderecoUF = newValue;
                  });
                },
              )),
            ),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Bairro'))),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'CEP'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Telefone'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Celular'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'E-mail'))),
          ],
        ),
      ],
    );
  }
}

class ContactsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.phone, size: 24),
            SizedBox(width: 8),
            Text('Contatos', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Nome Contato'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Número de Contato'))),
            SizedBox(width: 16),
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'E-mail'))),
          ],
        ),
      ],
    );
  }
}

class IssSection extends StatelessWidget {
  final TextEditingController dateController;

  IssSection({
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.money_off, size: 24),
            SizedBox(width: 8),
            Text('ISS', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox(width: 100, child: CustomTextField(label: 'Número'))),
            SizedBox(width: 16),
            Expanded(child: CustomTextField(label: 'Data de Vencimento', controller: dateController)),
          ],
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  CustomTextField({required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
