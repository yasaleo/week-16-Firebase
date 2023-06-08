import 'package:firebase_week_16/model/dummy_data.dart';
import 'package:flutter/material.dart';

class SliverScreen extends StatelessWidget {
  const SliverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            elevation: 10,
            expandedHeight: 280,
            collapsedHeight: 60,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              collapseMode: CollapseMode.pin,
              background: ShaderMask(
                blendMode: BlendMode.dstOut,
                shaderCallback: (rect) => const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.white])
                    .createShader(rect),
                child: Image.asset(
                  'assets/Dash_Phone_Games_v04.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                'Sliver',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                primary: true,
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Theme.of(context).colorScheme.onPrimary,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Center(
                              child: Text("${index + 1}"),
                            ),
                          ),
                          title: Text(tableData[index]["BILL_NAME"]),
                        ),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
