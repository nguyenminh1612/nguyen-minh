import java.time.LocalDate;
import java.util.Random;

public class As_2 {
	public static void main(String[] args) {
		String[] ho = new String[7];
			ho[0] = "Nguyen";
			ho[1] = "Le";
			ho[2] = "Bui";
			ho[3] = "Duong";
			ho[4] = "Hoang";
			ho[5] = "Cu";
			ho[6] = "Do";
		String[] dem = new String[7];
			dem[0] = "Le";
			dem[1] = "Thi";
			dem[2] = "Duy";
			dem[3] = "Thai";
			dem[4] = "Hoang";
			dem[5] = "Minh";
			dem[6] = "Thuan";
		String[] ten = new String[7];
			ten[0] = "Minh";
			ten[1] = "Thuy Trang";
			ten[2] = "Hieu";
			ten[3] = "Son";
			ten[4] = "Chi";
			ten[5] = "Giang";
			ten[6] = "An";
		String[] ht = new String[10];
		Random rd = new Random();
		// Câu 1
		System.out.println("Cau 1");
		for (int i = 0; i < 10; i++) {
			int randomHo = rd.nextInt(ho.length);
			int randomDem = rd.nextInt(dem.length);
			int randomTen = rd.nextInt(ten.length);
			ht[i] = ho[randomHo] + " " + dem[randomDem] + " " + ten[randomTen];
			System.out.println(ht[i]);
			}
		// Câu 2
		System.out.println("Cau 2");
		String msv[] = new String[10];
		for (int i = 0; i < 10; i++) {
			int code = (int) Math.floor(((Math.random() * 8999999) + 1000000));
			// Hàm math.floor() làm tròn dưới số
			// Hàm math.random() trả về một số ngẫu nhiên trong khoảng 0.0 và 1.0
			msv[i] = "SV" + Integer.toString(code);
			System.out.println(msv[i]);
		}
		// Câu 3
		System.out.println("Cau 3");
		String[] ngaysinh = new String[10];
//		ngaysinh[0] = "01/02/1991";
//		ngaysinh[1] = "02/02/1991";
//		ngaysinh[2] = "03/03/1991";
//		ngaysinh[3] = "04/04/1991";
//		ngaysinh[4] = "05/05/1991";
//		ngaysinh[5] = "06/06/1991";
//		ngaysinh[6] = "07/07/1991";
//		ngaysinh[7] = "08/08/1991";
//		ngaysinh[8] = "09/09/1991";
//		ngaysinh[9] = "10/10/1991";
		for (int i = 0; i < ngaysinh.length; i++) {
			int randomMonth = rd.nextInt(11)+1;
			int randomDay = rd.nextInt(31)+1;
			if (randomMonth == 2 && randomDay > 28) {
				ngaysinh[i] = (randomDay - 3) + "/" + randomMonth + "/" + "1991";
				System.out.println(ngaysinh[i]);
			} else if ((randomMonth %2 == 0 && randomMonth != 8) && randomDay == 31) {
				ngaysinh[i] = (randomDay - 1) + "/" + randomMonth + "/" + "1991";
				System.out.println(ngaysinh[i]);
			} else {
				ngaysinh[i] = randomDay + "/" + randomMonth + "/" + "1991";
				System.out.println(ngaysinh[i]);
			}
		}
		// Câu 4
		System.out.println("Cau 4");
		String[] Info= new String[10];
		for(int i=0;i<ht.length;i++) {
			int randomHT = rd.nextInt(ht.length);
			int randomMSV = rd.nextInt(msv.length);
			int randomNgaySinh = rd.nextInt(ngaysinh.length);
			Info[i] = ht[randomHT] +" - " + msv[randomMSV] + " - " + ngaysinh[randomNgaySinh];
			System.out.println(Info[i]);
		}
	}
}
