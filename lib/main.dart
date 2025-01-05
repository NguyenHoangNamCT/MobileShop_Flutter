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
        title: buildTextOfAppbarTitle(),
        backgroundColor: Colors.blue,
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
      body: Center(
        child: Text('Nội dung chính ở đây'),
      ),
    );
  }
}

ListTile buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
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

class buildListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class buildListViewState extends State<buildListView>{
  @override
  Widget build(BuildContext context) {
    return ListView();
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
