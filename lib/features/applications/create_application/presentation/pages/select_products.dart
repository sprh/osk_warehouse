part of '../create_appication_page.dart';

class _SelectProducts extends StatelessWidget {
  final List<OskCreateApplicationProduct> products;
  final VoidCallback onAddProductsTap;
  final VoidCallback onNextTap;
  final void Function(String) onRemove;
  final void Function(String, int) onChangeCount;
  final VoidCallback onBackTap;

  const _SelectProducts({
    required this.products,
    required this.onAddProductsTap,
    required this.onNextTap,
    required this.onRemove,
    required this.onChangeCount,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return OskScaffold.slivers(
      header: OskScaffoldHeader(
        leading: const OskServiceIcon.request(),
        title: 'Выберите товары',
        actions: const [
          OskCloseIconButton(),
          SizedBox(width: 8),
        ],
      ),
      actionsDirection: Axis.horizontal,
      customActions: OskActionsFlex(
        direction: Axis.vertical,
        maxWidth: size.width,
        widgets: [
          OskButton.minor(
            title: 'Добавить товары ',
            onTap: onAddProductsTap,
          ),
          OskActionsFlex(
            maxWidth: size.width,
            widgets: [
              OskButton.minor(
                title: 'Назад',
                onTap: onBackTap,
              ),
              OskButton.main(
                title: 'Далее',
                state: products.isEmpty
                    ? OskButtonState.disabled
                    : OskButtonState.enabled,
                onTap: onNextTap,
              ),
            ],
          ),
        ],
      ),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 8),
          sliver: SliverList.separated(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              final canRemove = product.count > 1;
              final canAdd =
                  product.maxCount == null || product.count < product.maxCount!;

              return Center(
                child: OskInfoSlot.dismissible(
                  dismissibleKey: ValueKey(product.product.id),
                  onDelete: () async {
                    onRemove(product.product.id);
                    return Future.value(false);
                  },
                  title: product.product.name,
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IgnorePointer(
                        ignoring: !canRemove,
                        child: Opacity(
                          opacity: !canRemove ? 0.5 : 1.0,
                          child: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => onChangeCount(
                              product.product.id,
                              product.count - 1,
                            ),
                          ),
                        ),
                      ),
                      OskText.caption(
                        text: product.count.toString(),
                        fontWeight: OskfontWeight.medium,
                      ),
                      IgnorePointer(
                        ignoring: !canAdd,
                        child: Opacity(
                          opacity: !canAdd ? 0.5 : 1.0,
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => onChangeCount(
                              product.product.id,
                              product.count + 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          ),
        ),
      ],
    );
  }
}
