import 'dart:io';
import 'package:aoun1/HomePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'HomePage.dart';

class ReportForm extends StatefulWidget {
  ReportForm({Key? key}) : super(key: key);

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final MapController _mapController = MapController();

  XFile? _selectedImage;
  LatLng _selectedLocation = LatLng(31.9454, 35.9284); // Default: Amman
  List<LatLng> _markers = [];

  String? _selectedDepartment;
  final List<String> _departments = [
    'البلدية',
    'الصيانة العامة',
    'النظافة العامة',
    'إنارة الشوارع',
    'الطرق والشوارع',
    'الحدائق والمتنزهات',
    'المياه والصرف الصحي',
    'الكهرباء',
    'الغاز الطبيعي',
    'الاتصالات والإنترنت',
    'الدفاع المدني',
    'الأمن العام',
    'الإطفاء',
    'وزارة النقل',
    'المرور',
    'النقل العام',
    'وزارة الزراعة',
    'البيئة',
    'الحدائق والمحميات الطبيعية',
    'وزارة الصحة',
    'المستشفيات الحكومية',
    'مراكز الرعاية الصحية',
    'التعليم',
    'أخرى',
  ];


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // //////////////////// IMAGE ////////////////////
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 2800,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() => _selectedImage = image);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('فشل تحميل الصورة: $e')));
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageOption(Icons.camera_alt, 'التقاط صورة', () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            }),
            _buildImageOption(Icons.photo_library, 'اختيار من المعرض', () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            }),
            if (_selectedImage != null)
              _buildImageOption(Icons.delete, 'إزالة الصورة', () {
                setState(() => _selectedImage = null);
                Navigator.pop(context);
              }, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(IconData icon, String text, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(text, textAlign: TextAlign.right),
      ),
      onTap: onTap,
    );
  }

  Widget _buildImageWidget() {
    if (_selectedImage == null) {
      return Center(
        child: Icon(Icons.image_outlined, size: 80, color: Colors.grey[400]),
      );
    }
    return kIsWeb
        ? Image.network(_selectedImage!.path,
        width: 2800, height: 1600, fit: BoxFit.cover)
        : Image.file(File(_selectedImage!.path),
        width: 2800, height: 1600, fit: BoxFit.cover);
  }

  //////////////////// MAP ////////////////////
  void _addMarker(LatLng point) {
    setState(() {
      _selectedLocation = point;
      _markers = [point];
    });
    _mapController.move(point, 15);
  }

  Future<void> _getCurrentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final pos = await Geolocator.getCurrentPosition();
      final current = LatLng(pos.latitude, pos.longitude);

      setState(() {
        _selectedLocation = current;
        _markers = [current];
      });

      _mapController.move(current, 15);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('فشل الحصول على الموقع: $e')));
    }
  }

  //////////////////// ACTIONS ////////////////////
  void _submitReport() {
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء إدخال وصف البلاغ')));
      return;
    }

    if (_selectedDepartment == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('اختر الجهة المسؤولة')));
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('تم إرسال البلاغ بنجاح')));

    // Debug info
    print('وصف البلاغ: ${_descriptionController.text}');
    print('الجهة: $_selectedDepartment');
    print(
        'الموقع: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}');
    print('صورة: ${_selectedImage != null ? "مرفقة" : "لا"}');
  }

  void _cancelReport() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );

  //////////////////// UI ////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 300),
              Image.asset(
                "assets/images/logowithouttext.png",
                width: 103.1,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child:SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImageSection(),
              SizedBox(height: 24),
              _buildLabelWithIcon(Icons.description, 'وصف المشكلة'),
              SizedBox(height: 8),
              _buildTextField(_descriptionController),
              SizedBox(height: 24),
              _buildLabelWithIcon(Icons.business, 'الجهة المسؤولة'),
              SizedBox(height: 8),
              _buildDropdown(),
              SizedBox(height: 24),
              _buildLabelWithIcon(Icons.location_on, 'موقع البلاغ'),
              SizedBox(height: 8),
              _buildMap(),
              SizedBox(height: 12),
              _buildStatus(),
              SizedBox(height: 24),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////
  Widget _buildImageSection() {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImageWidget(),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: _EditIcon(),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelWithIcon(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFF2563EB), size: 20),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
              color: Color(0xFF2563EB), fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF2563EB), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: 5,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
          hintText: '',
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF2563EB), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDepartment,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF2563EB)),
          hint: Text('', textAlign: TextAlign.right, style: TextStyle(fontSize: 14)),
          items: _departments
              .map((d) => DropdownMenuItem(
            value: d,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(d, style: TextStyle(fontSize: 14))),
          ))
              .toList(),
          onChanged: (v) => setState(() => _selectedDepartment = v),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _selectedLocation,
            initialZoom: 14,
            onTap: (tap, point) => _addMarker(point),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: _markers
                  .map(
                    (p) => Marker(
                  point: p,
                  width: 40,
                  height: 40,
                  child: Icon(Icons.location_pin,
                      color: Colors.red, size: 40),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.radar, color: Color(0xFF2563EB), size: 18),
        SizedBox(width: 6),
        Text(
          'حالة البلاغ: ــ ــ',
          style: TextStyle(
              color: Color(0xFF2563EB), fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _cancelReport,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text('إلغاء',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _submitReport,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: Text('إرسال',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }
}

class _EditIcon extends StatelessWidget {
  _EditIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration:
      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Icon(Icons.edit, color: Color(0xFF2563EB), size: 20),
    );
  }
}
