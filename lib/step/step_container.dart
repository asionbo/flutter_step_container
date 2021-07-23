import 'package:flutter/material.dart';

import 'step_model.dart';

/// StepContainer 0.1
/// For purpose used in product introduce or form submit and so on.
/// TODO 进度头部展示配置 step display at top configuration
class StepContainer extends StatefulWidget {
  /// 容器子组件，每个为一页
  /// Container sub-components , each of which is a page.
  final List<StepModel> models;

  /// 完成展示页 （在点击最后的 "完成" 后跳转）
  /// The finish page (jump after the last "finished" words tapped).
  final Widget finishView;

  /// 完成展示页 完成按钮 回调
  /// The finish page's complete button callback.
  final ValueChanged<String> finishCallBack;

  const StepContainer(
      {@required this.models, this.finishView, this.finishCallBack})
      : assert(models != null && models.length > 0,
            '\"models\" must not be null or empty!');

  @override
  _StepContainerState createState() {
    return _StepContainerState();
  }
}

class _StepContainerState extends State<StepContainer> {
  final PageController _pageController = PageController();

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController?.addListener(() {
      print(_pageController.page);
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isFinish = widget.finishView == null;

    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: PageView.builder(
          itemBuilder: (btx, index) {
            var e = widget.models[index];
            return Column(
              children: [e.title, e.content],
            );
          },
          itemCount: widget.models.length,
          controller: _pageController,
          onPageChanged: (index) {
            if (!mounted) {
              return;
            }
            setState(() {
              _currentPage = index + 1;
            });
          },
        )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Visibility(
                    visible: _currentPage > 1,
                    child: TextButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        }
                      },
                      child: Text('Previous'),
                    ))),
            TextButton(
                onPressed: () {},
                child: Text(
                    'Current progress$_currentPage/${widget.models.length}')),
            FractionallySizedBox(),
            Expanded(
                child: TextButton(
                    onPressed: () async {
                      if (_currentPage == widget.models.length) {
                        if (!_isFinish) {
                          var sheet = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.9),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    AppBar(
                                      title: Text(
                                        'Review',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      )),
                                    ),
                                    Expanded(child: widget.finishView),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'blablabla');
                                          if (widget.finishCallBack != null)
                                            widget.finishCallBack('finished');
                                        },
                                        child: Text('Finish'))
                                  ],
                                ),
                              ),
                            ),
                          );
                          print(sheet);
                        } else {
                          if (widget.finishCallBack != null)
                            widget.finishCallBack('finish');
                        }
                      } else {
                        if (_pageController.hasClients) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        }
                      }
                    },
                    child: Text(
                        (!_isFinish && widget.models.length == _currentPage)
                            ? 'Finish'
                            : 'Next')))
          ],
        )
      ],
    ));
  }
}
