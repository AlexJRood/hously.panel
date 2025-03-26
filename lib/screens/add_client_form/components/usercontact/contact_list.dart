import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hously_flutter/screens/add_client_form/add_client_form_pc.dart';

const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';

class ClientListAddFormCrm extends ConsumerStatefulWidget {
  const ClientListAddFormCrm({super.key});

  @override
  ConsumerState<ClientListAddFormCrm> createState() => _ClientListAppBarState();
}

class _ClientListAppBarState extends ConsumerState<ClientListAddFormCrm> {
  bool isExpanded = false; 
  TextEditingController searchController = TextEditingController();
  late final ScrollController _scrollController;

  /// Klient wybrany z listy (null = brak wyboru)
  UserContactModel? selectedClient;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Jeśli mamy wybranego klienta, pokaż jego nazwę, avatar itp.
        // W przeciwnym wypadku pokazujemy ikonę lupy i (po rozwinięciu) listę klientów.
        if (selectedClient != null)
          // --- Wiersz z wybranym klientem ---
          Container(
            height: 50,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(35, 35, 35, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    selectedClient?.avatar ?? defaultAvatarUrl,
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${selectedClient?.name ?? ''} ${selectedClient?.lastName ?? ''}',
                    style: AppTextStyles.interRegular14.copyWith(
                      color: Theme.of(context).iconTheme.color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Ikonka do wyczyszczenia wyboru
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      selectedClient = null;
                      searchController.clear();
                    });
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          )
        else
          // --- Search / Rozwijana lista klientów ---
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: ClipRRect(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isExpanded ? 600 : 50,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(35, 35, 35, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: isExpanded
                          ? Column(
                              children: [
                                // Pole wyszukiwania
                                Focus(
                                  onFocusChange: (hasFocus) {
                                    if (!hasFocus) {
                                      setState(() {
                                        isExpanded = false;
                                      });
                                    }
                                  },
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: (value) {
                                      ref
                                          .watch(clientProvider.notifier)
                                          .fetchClients(searchQuery: value);
                                    },
                                    onSubmitted: (value) {
                                      ref
                                          .watch(clientProvider.notifier)
                                          .fetchClients(searchQuery: value);
                                      setState(() {
                                        isExpanded = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Szukaj klienta...'.tr,
                                      hintStyle: const TextStyle(
                                        color: Color.fromRGBO(233, 233, 233, 1),
                                        fontSize: 14,
                                      ),
                                      focusColor:
                                          const Color.fromRGBO(35, 35, 35, 1),
                                      fillColor:
                                          const Color.fromRGBO(35, 35, 35, 1),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                        ),
                                      ),
                                    ),
                                    cursorColor: Colors.white,
                                  ),
                                ),
                                // Lista klientów
                                Expanded(child: clientList(context, ref)),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.search,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 25),
                                // Przykładowy przycisk: "New user"
                                InkWell(
                                  onTap: () {
                                    ref.read(showUserContactsProvider.notifier)
                                        .state = true;
                                  },
                                  child: Container(
                                    width: 99,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                        ),
                                        Text(
                                          'New user',
                                          style: TextStyle(
                                            color: Color.fromRGBO(35, 35, 35, 1),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget clientList(BuildContext context, WidgetRef ref) {
    final clientListAsyncValue = ref.watch(clientProvider);

    return clientListAsyncValue.when(
      data: (clients) {
        if (clients.isEmpty) {
          return _buildNoClientsMessage(context, ref);
        }
        return _buildClientList(context, ref, clients);
      },
      loading: () => _buildLoadingState(context, ref),
      error: (err, stack) => _buildErrorState(context, ref),
    );
  }

  Widget _buildNoClientsMessage(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            height: 32,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.adGradient1(context, ref),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'No clients available',
                  style: AppTextStyles.interRegular12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientList(
    BuildContext context,
    WidgetRef ref,
    List<UserContactModel> clients,
  ) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _scrollController.jumpTo(
          _scrollController.offset - details.delta.dx,
        );
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: clients.map((client) => _buildClientCard(context, ref, client)).toList(),
        ),
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, WidgetRef ref, UserContactModel client) {
    return InkWell(
      onTap: () {
        // Po kliknięciu w klienta - ustawiamy go jako selectedClient i zwijamy listę
        setState(() {
          selectedClient = client;
          isExpanded = false;
        });
        
        ref.read(addClientFormProvider.notifier).setSelectedClientId(client.id);

      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: CustomBackgroundGradients.crmadgradient(context, ref),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundImage: NetworkImage(client.avatar ?? defaultAvatarUrl),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Text(
                client.name,
                style: AppTextStyles.interRegular14.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                client.lastName ?? '',
                style: AppTextStyles.interRegular14.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context, WidgetRef ref) {
    return _buildShimmerLoading(context, ref);
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref) {
    return _buildShimmerLoading(context, ref, showErrorIcon: true);
  }

  Widget _buildShimmerLoading(
    BuildContext context,
    WidgetRef ref, {
    bool showErrorIcon = false,
  }) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          10,
          (index) => Container(
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: CustomBackgroundGradients.crmadgradient(context, ref),
            ),
            child: Center(
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      if (showErrorIcon)
                        const Positioned(
                          left: 5,
                          top: 5,
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 160,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
