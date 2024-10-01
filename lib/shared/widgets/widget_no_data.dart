import 'package:bi_ufcg/shared/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';

class WidgetNoData extends StatelessWidget {
  const WidgetNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        key: const ValueKey('no_data'),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.colors.quinary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.data_usage_outlined,
              size: MediaQuery.of(context).size.width * 0.1,
              color: Colors.grey.shade300,
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              'Nenhum dado disponível',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              'Por favor, adicione pelo menos 1 curso e 1 período para visualizar os dados.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
