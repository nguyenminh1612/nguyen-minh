import java.util.Random;

public class Assignment_2_3 {
	public static void main(String[] args) {
		// Assignment 2
		String[] FirstName = new String[7];
		FirstName[0] = "Nguyen";
		FirstName[1] = "Trann";
		FirstName[2] = "Phann";
		FirstName[3] = "Duong";
		FirstName[4] = "Hoang";
		FirstName[5] = "Cuong";
		FirstName[6] = "Langg";
		String[] MiddleName = new String[7];
		MiddleName[0] = "Longg";
		MiddleName[1] = "Thinh";
		MiddleName[2] = "Doann";
		MiddleName[3] = "Thaii";
		MiddleName[4] = "Thuan";
		MiddleName[5] = "Minhh";
		MiddleName[6] = "Thuan";
		String[] LastName = new String[7];
		LastName[0] = "Minhh";
		LastName[1] = "Trang";
		LastName[2] = "Hieuu";
		LastName[3] = "Hungg";
		LastName[4] = "Chinh";
		LastName[5] = "Giang";
		LastName[6] = "Ngocc";
		Random rd = new Random();
		// Câu 1
		System.out.println("Cau 1");
		String[] FullName = new String[10];
		for (int i = 0; i < FullName.length; i++) {
			int randomFirstName = rd.nextInt(FirstName.length);
			int randomMiddleName = rd.nextInt(MiddleName.length);
			int randomLastName = rd.nextInt(LastName.length);
			FullName[i] = FirstName[randomFirstName] + " " + MiddleName[randomMiddleName] + " "
					+ LastName[randomLastName];
			System.out.println(FullName[i]);
		}
		// Câu 2
		System.out.println("Cau 2");
		String ID[] = new String[10];
		for (int i = 0; i < ID.length; i++) {
			int id = (int) Math.floor(((rd.nextFloat() * 8999999) + 1000000));
			// Hàm math.floor() làm tròn dưới số
			// Hàm nextFloat() trả về một số ngẫu nhiên trong khoảng [0.0, 1.0f)
			ID[i] = "SV" + id;
			System.out.println(ID[i]);
		}
		// Câu 3
		System.out.println("Cau 3");
		String[] BirthDay = new String[10];
		for (int i = 0; i < BirthDay.length; i++) {
			int randomMonth = rd.nextInt(11) + 1;
			if (randomMonth == 2) {
				int randomDay = rd.nextInt(27) + 1;
				BirthDay[i] = randomDay + "/" + randomMonth + "/" + "1991";
			} else if (randomMonth == 4 || randomMonth == 6 || randomMonth == 9 || randomMonth == 10) {
				int randomDay = rd.nextInt(29) + 1;
				BirthDay[i] = randomDay + "/" + randomMonth + "/" + "1991";
			} else {
				int randomDay = rd.nextInt(30) + 1;
				BirthDay[i] = randomDay + "/" + randomMonth + "/" + "1991";
			}
			System.out.println(BirthDay[i]);
		}
		// Câu 4
		System.out.println("Cau 4");
		System.out.println("Full Name		ID		Birth Day");
		System.out.println("--------------------------------------------------");
		String[] Info = new String[10];
		for (int i = 0; i < FullName.length; i++) {
			Info[i] = FullName[i] + " 	" + ID[i] + "	" + BirthDay[i];
			System.out.println(Info[i]);
		}
		// Assignment 3
		// Câu 1
		System.out.println("Assignment 3");
		System.out.println("Full Name		ID		Birth Day	RA	SD	CP	CUT	FMT	AVG");
		System.out.println("----------------------------------------------------------------------------------------------------");
		int[] RA = { 8, 5, 6, 7, 3, 4, 3, 1, 2, 0 };
		int[] SD = { 0, 2, 1, 8, 5, 6, 7, 4, 3, 3 };
		int[] CP = { 4, 3, 3, 0, 2, 1, 7, 6, 5, 8 };
		int[] CUT = { 4, 8, 3, 5, 3, 6, 0, 2, 1, 7 };
		int[] FMT = { 4, 7, 8, 3, 5, 3, 6, 2, 1, 0 };
		float[] AVG = new float[10];
		for (int i = 0; i < AVG.length; i++) {
			AVG[i] = (float) (RA[i] + SD[i] + CP[i] + CUT[i] + FMT[i]) / 5;
		}
		// Câu 2
		// Sắp xếp
		sortDESC(AVG);
		String[] InfoScores = new String[10];
		for (int i = 0; i < InfoScores.length; i++) {
			InfoScores[i] = (String) Info[i] + "	" + RA[i] + "	" + SD[i] + "	" + CP[i] + "	" + CUT[i] + "	"
					+ FMT[i] + "	" + AVG[i];
			System.out.println(InfoScores[i]);
		}
	}
	// Hàm sắp xếp mảng giảm dần
	public static void sortDESC(float[] arr) {
		float temp = arr[0];
        for (int i = 0 ; i < arr.length - 1; i++) {
            for (int j = i + 1; j < arr.length; j++) {
                if (arr[i] < arr[j]) {
                    temp = arr[j];
                    arr[j] = arr[i];
                    arr[i] = temp;
                }
            }
        }
	}
}
