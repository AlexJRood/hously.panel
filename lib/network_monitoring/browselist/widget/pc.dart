import 'package:flutter/material.dart';
import 'package:hously_flutter/network_monitoring/browselist/components/button.dart';
import 'package:hously_flutter/network_monitoring/browselist/components/list.dart';

class BrowseListNetworkMonitoringPcWidget extends StatefulWidget {
  final bool isWhiteSpaceNeeded;
  const BrowseListNetworkMonitoringPcWidget({super.key, required this.isWhiteSpaceNeeded});

  @override
  _BrowseListNetworkMonitoringPcWidgetState createState() => _BrowseListNetworkMonitoringPcWidgetState();
}

class _BrowseListNetworkMonitoringPcWidgetState extends State<BrowseListNetworkMonitoringPcWidget> {
  bool _isHidden = false;

  void _toggleWidget() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pełna szerokość widgetu oraz szerokość, gdy widget jest „schowany”
    double screenWidth = MediaQuery.of(context).size.width;
    

    const double maxWidth = 2800;
    const double minWidth = 1080;
    const double maxbrowseListWidth = 450;
    const double minbrowseListWidth = 180;
    double browseListWidth = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxbrowseListWidth - minbrowseListWidth) +
        minbrowseListWidth;
    browseListWidth = browseListWidth.clamp(minbrowseListWidth, maxbrowseListWidth);


    double fullWidth = browseListWidth;
    const double peekWidth = 80; 
    final double containerWidth = _isHidden ? peekWidth : fullWidth;



    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: containerWidth,
      // AnimatedContainer dostosowuje szerokość, dzięki czemu pozostała część UI rozszerzy się, gdy widget się zwęża.
      child: Stack(
        children: [
          // Zawsze wyświetlamy zawartość listy, lecz przy zwężonej szerokości część listy będzie ukryta
          Positioned.fill(
            child: BrowseListWidgetNM(isWhiteSpaceNeeded: widget.isWhiteSpaceNeeded, isHidden: _isHidden),
          ),
          // Nagłówek z przyciskiem przełączającym
          Positioned(
            top: widget.isWhiteSpaceNeeded ? 58 : 0,
            right: 0,
            left: 0,
            child: BrowseListButtonBarWidget(isHidden: _isHidden, toggleIsHidden: _toggleWidget)
          ),
          Positioned(
            bottom: 10,
            right: 20,
            left: 10,
            child: BrowseListActionsWidget(isHidden: _isHidden, toggleIsHidden: _toggleWidget)
          ),
        ],
      ),
    );
  }
}
