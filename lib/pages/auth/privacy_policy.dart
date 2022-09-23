import 'package:Design/utile/constants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  static const routeName = '/PrivacyPolicyScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الاستخدام و الخصوصية',style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontFamily: fontFamilayTajawal,
        ),),
        backgroundColor: kPrimaryColor,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RichText(
              textScaleFactor: 1.5,
              text: const TextSpan(
                text: 'اتفاقية الاستخدام \n\n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontFamily: fontFamilayTajawal,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'في التطبيق يوجد أكثر من مستخدم قد يكون مستخدم (زبون) أو عضو (مقدم خدمة) سواء كان تصميم أو أي خدمة أخرى. \n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text: 'يضيف العضو مقدم الخدمة -التصميم- بإضافة رابط التصميم  في التطبيق. \n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text: 'نعرص في متجرنا تصاميم تفاعلية للمنهج التعليمي مما تساعد المعلمين و الطلاب. \n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text:
                          'بحيث نقدم عرض بوربوينت و أوراق عمل بطريقة عصرية مما يسهل العملية التعليمية للطلاب و المعلمين. \n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text:
                          ' برمجنا في متجرنا (خاصية مشاركة للرابط بعد الدفع عبر الواتس اب ) - أو  عرضه في قائمة طلبات المستخدم في التطبيق.\n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text:
                          'رغم خطورة هذا الأمر علينا لسهولة نشر هذا الرابط ووصوله لأشخاص لم ( يدفعوا بمقابله ) وبناءاً عليه :\n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12,fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'نود أن ننوه أن ( الحقوق محفوظة ) لجميع منتجاتنا في المتجر.\n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text: 'وأننا لا نحلل نشر أو إعارة أو نسخ روابطنا وعروضنا لأي شخص آخر وأن يكون شراءك لها بقصد',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text: ' الاستخدام الشخصي فقط.\n',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamilayTajawal, fontSize: 12)),
                  TextSpan(
                      text: 'ومن يفعل عكس ذلك يحق لنا ملاحقته قانونياً ولن يتم التنازل عن الدعوى لأي سبب كان.\n',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                  TextSpan(
                      text: 'وكلنا ثقة في عملاءنا الكرام ولكن جرى التنويه فقط لهذا الأمر.',
                      style: TextStyle(fontFamily: fontFamilayTajawal, color: Colors.black, fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
