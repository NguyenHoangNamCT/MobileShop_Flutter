import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildTextOfAppbarTitle(), //gọi đến một hàm tự xây, hàm này trả về một widget Text
        backgroundColor: Colors.blue, //đổi màu cho appbar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Xóa khoảng cách mặc định
          children: [
            DrawerHeader(
              decoration: BoxDecoration( //dùng để trang trái widget hình hộp
                color: Color(0xFF0049F8), // set màu cho drawer header
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //canh lề trái tất cả các wiget con
                children: [
                  CircleAvatar( //widget hiện ảnh theo hình tròn
                    radius: 30, //bán kính của hình ảnh
                    backgroundImage: AssetImage('assets/avatar.jpg'), // Thay bằng ảnh của bạn
                  ),
                  SizedBox(height: 10), // tạo khoảng cách giữa các widget (gống margin mà tiện hơn)
                  Text(
                    'Xin chào!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            buildMenuItem( // gọi 1 hàm tự xây, hàm này trả về một ListTitle
                context,
                Icons.home,
                'Trang chủ',
                    (){}
            ),
            buildMenuItem(
                context,
                Icons.category,
                'Danh mục',
                    (){}
            ),
            buildMenuItem(
                context,
                Icons.settings,
                'Cài đặt',
                    (){}
            ),
            buildMenuItem(
                context,
                Icons.logout,
                'Đăng xuất',
                    (){}
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(//
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //canh lề các phẩn tử con theo chiều ngang (start = lề trái)
          children: [
            // Banner quảng cáo
            buildBanner(),
            buildSectionTitle('Danh mục'),
            buildCategoryList(),
            buildSectionTitle('Sản phẩm mới'),
            buildProductGrid(),
          ],
        ),
      ),
    );
  }
}

// danh mục 1
Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}


//danh mục 3
Widget buildCategoryList() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 80.0, // Chiều cao của danh mục
    child: ListView(
      scrollDirection: Axis.horizontal, // Cuộn ngang
      children: [
        CategoryItem(icon: Icons.phone_android, label: 'Điện thoại'),
        CategoryItem(icon: Icons.tablet, label: 'Máy tính bảng'),
        CategoryItem(icon: Icons.laptop, label: 'Laptop'),
        CategoryItem(icon: Icons.headphones, label: 'Phụ kiện'),
        CategoryItem(icon: Icons.tv, label: 'Tivi'),
      ],
    ),
  );
}

//danh mục 2
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Chiều rộng của mỗi danh mục
      margin: EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25, // Kích thước biểu tượng
            backgroundColor: Colors.blueAccent,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget buildBanner(){
  return Container(
    height: 150,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration( //trang trí container
      borderRadius: BorderRadius.circular(12), //bo gốc bàn kính 12px
      image: DecorationImage( //để trang trí
        // image: NetworkImage('https://i.pinimg.com/564x/db/85/99/db85998510e152f6d02214da2b70ab60.jpg'), //ảnh điện thoại
        // image: NetworkImage('https://images.pexels.com/photos/7919/pexels-photo.jpg'), //ảnh 32:9
        image: NetworkImage('https://mega.com.vn/media/news/0106_hinh-nen-may-tinh-full-hd88.jpg'), //gắn 1 hình ảnh từ link //ảnh 16:9
        fit: BoxFit.cover, // cách hình ảnh hiển thị (phóng to thu nhỏ hình ảnh để fill khung hình, hỉnh ảnh không bị méo nhưng sẽ bị cắt góc)
      ),
    ),
  );
}

//ListTile trong drawer
ListTile buildMenuItem(
    BuildContext context, //dùng để xác định vị trí của widget trong cây widget
    IconData icon, //là một icon
    String title,
    VoidCallback onTap, //một hàm không có giá trị trả về
    ) {
  return ListTile(
    leading: Icon(icon), //hiện icon đầu tiên
    title: Text(title), //tiêu đề
    onTap: () { //sự kiện khi click
      // Navigator.pop(context); // Đóng Drawer
      onTap();
    },
  );
}



class buildTextOfAppbarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Trang chủ",
      textAlign: TextAlign.left,
      style: TextStyle(
          color: Colors.yellow,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );
  }
}

Widget buildProductGrid() {
  return GridView.builder(
    shrinkWrap: true, // Tránh lỗi layout overflow
    physics: NeverScrollableScrollPhysics(), // Tắt cuộn riêng trong GridView (tránh cuộn kép)
    padding: EdgeInsets.all(16.0),
    itemCount: 6, // Số lượng sản phẩm hiển thị
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( //giúp định nghĩa các bố cục của GridView
      crossAxisCount: 2, // Số cột
      childAspectRatio: 3/4, // tỷ lệ khung hình: cao chia rộng
      // childAspectRatio: 0.75, // Tỉ lệ khung hình (3/4=0.75)
      crossAxisSpacing: 16.0, // Khoảng cách giữa các cột
      mainAxisSpacing: 16.0, // Khoảng cách giữa các hàng
    ),
    itemBuilder: (context, index) {
      return ProductCard(
        imageUrl: 'https://media.doanhnghiepvn.vn/Images/Uploaded/Share/2024/11/11/Bang-gia-Samsung-Galaxy-moi-nhat-thang-11-Galaxy-S24-Ultra-giam-cuc-gat-dap-tra-iPhone-16-pro-Max_1.jpg?format%3Dwebp', // Ảnh sản phẩm
        name: 'Sản phẩm ${index + 1}', // Tên sản phẩm
        price: '${(index + 1) * 1000000} VNĐ', // Giá sản phẩm
        onTap: () {
          // Chuyển tới chi tiết sản phẩm
        },
      );
    },
  );
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback onTap;

  const ProductCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //bắt sự kiện khi người dùng thao tác vào sản phẩm
      onTap: onTap, // Xử lý khi nhấn vào sản phẩm
      child: Card(
        shape: RoundedRectangleBorder(//dùng để thay đổi hình dạng của card
          borderRadius: BorderRadius.circular(12.0), //bo cart 12px
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded( //wiget chiếm full không gian còn trống của widget cha
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)), //bo tròn 2 góc trên 12px
                child: Image.network( //hiển thị hình ảnh trên mạng
                  imageUrl, //String link đến hình ảnh
                  fit: BoxFit.cover, //cover hình ảnh sẽ được phóng to thu nhỏ sao cho vừa tỉ lệ khung hình, hình ảnh sẽ không bị kéo dãn nhưng bị cắt bớt
                  width: double.infinity, //double.infinity yêu câu widget này chiếm toàn bộ chiều rộng của widget cha
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                price,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/* giao diện đã làm gọn
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang Chính'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            buildDrawerHeader(),
            buildMenuItem(
              context,
              Icons.home,
              'Trang chủ',
                  () => print('Trang chủ'),
            ),
            buildMenuItem(
              context,
              Icons.shopping_cart,
              'Giỏ hàng',
                  () => print('Giỏ hàng'),
            ),
            buildMenuItem(
              context,
              Icons.account_circle,
              'Tài khoản',
                  () => print('Tài khoản'),
            ),
          ],
        ),
      ),
      body: buildBody(),
    );
  }
}

DrawerHeader buildDrawerHeader() {
  return DrawerHeader(
    decoration: BoxDecoration(color: Colors.blueAccent),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/avatar.jpg'),
        ),
        SizedBox(height: 10),
        Text(
          'Xin chào!',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Text(
          'user@example.com',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    ),
  );
}

ListTile buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    ) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.pop(context); // Đóng Drawer
      onTap();
    },
  );
}

Widget buildBody() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBanner(),
        buildSectionTitle('Danh mục'),
        buildCategoryList(),
        buildSectionTitle('Sản phẩm mới'),
        buildProductGrid(),
      ],
    ),
  );
}

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildBanner() {
  return Container(
    margin: EdgeInsets.all(16.0),
    height: 150.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        image: AssetImage('assets/banner.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget buildCategoryList() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    height: 80.0,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CategoryItem(icon: Icons.phone_android, label: 'Điện thoại'),
        CategoryItem(icon: Icons.tablet, label: 'Máy tính bảng'),
        CategoryItem(icon: Icons.laptop, label: 'Laptop'),
        CategoryItem(icon: Icons.headphones, label: 'Phụ kiện'),
      ],
    ),
  );
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget buildProductGrid() {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.all(16.0),
    itemCount: 6,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
    ),
    itemBuilder: (context, index) {
      return ProductCard(
        imageUrl: 'assets/phone.jpg',
        name: 'iPhone 14 Pro',
        price: '30,000,000 VNĐ',
        onTap: () {
          // Điều hướng tới chi tiết sản phẩm
        },
      );
    },
  );
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback onTap;

  const ProductCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                price,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*
//all giao diện lúc chưa làm gọn
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Shop'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header của Drawer
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/avatar.jpg'), // Thay bằng ảnh của bạn
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Xin chào!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'user@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Các mục menu
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Trang chủ'),
              onTap: () {
                Navigator.pop(context);
                // Điều hướng tới Trang chủ
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Danh mục'),
              onTap: () {
                Navigator.pop(context);
                // Điều hướng tới Danh mục
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Giỏ hàng'),
              onTap: () {
                Navigator.pop(context);
                // Điều hướng tới Giỏ hàng
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Cài đặt'),
              onTap: () {
                Navigator.pop(context);
                // Điều hướng tới Cài đặt
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Đăng xuất'),
              onTap: () {
                Navigator.pop(context);
                // Xử lý Đăng xuất
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner quảng cáo
            Container(
              margin: EdgeInsets.all(16.0),
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('assets/banner.jpg'), // Thay bằng ảnh của bạn
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Danh mục
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Danh mục',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              height: 80.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryItem(icon: Icons.phone_android, label: 'Điện thoại'),
                  CategoryItem(icon: Icons.tablet, label: 'Máy tính bảng'),
                  CategoryItem(icon: Icons.laptop, label: 'Laptop'),
                  CategoryItem(icon: Icons.headphones, label: 'Phụ kiện'),
                ],
              ),
            ),

            // Danh sách sản phẩm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sản phẩm mới',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.0),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  imageUrl: 'assets/phone.jpg', // Thay bằng ảnh sản phẩm
                  name: 'iPhone 14 Pro',
                  price: '30,000,000 VNĐ',
                  onTap: () {
                    // Navigate to product details
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      margin: EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blueAccent,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback onTap;

  const ProductCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                price,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */
