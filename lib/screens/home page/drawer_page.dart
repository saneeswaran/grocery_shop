import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:grocery_shop/routes/route_model.dart';

class DrawerPage extends StatelessWidget {
  final Widget body;
  const DrawerPage({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AdvancedDrawerController controller = AdvancedDrawerController();
    void handleMenuButtonPressed() {
      controller.showDrawer();
    }

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: controller,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      drawer: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: ListView.builder(
              itemCount: pages.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final page = pages[index];
                return ListTile(
                  leading: Icon(page.icon),
                  title: Text(page.title),
                  trailing: Icon(Icons.arrow_right_outlined),
                  onTap: () => page.onTap(context),
                );
              },
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "GoFresh",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            ),
            Badge.count(
              count: 5,
              backgroundColor: Theme.of(context).primaryColor,
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.shopping_cart, color: Colors.grey),
              ),
            ),
            SizedBox(width: size.width * 0.05),
          ],
          leading: IconButton(
            onPressed: handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: controller,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: body,
      ),
    );
  }
}
