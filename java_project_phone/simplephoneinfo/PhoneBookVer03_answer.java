package simplephoneinfo;

import java.util.Scanner;

class PhoneBookManager2 {
    private static final int size=100;
    PhoneInfo[] infoStorage; // 전화번호 저장하는 객체배열
    String name, phone, birth = null;
    private int cnt = 0; // 현재 저장된 객체들의 인덱스

    public PhoneBookManager2(){
        infoStorage = new PhoneInfo[size];
    }

    public void input() {
        System.out.println("데이터 입력을 시작합니다.");
        System.out.print("이름 : ");
        name = MenuViewer.sc.nextLine();
        System.out.print("전화번호 : ");
        phone = MenuViewer.sc.nextLine();
        System.out.print("생년월일 : ");
        birth = MenuViewer.sc.nextLine();
        System.out.println("데이터 입력이 완료되었습니다.");
        infoStorage[cnt++] = new PhoneInfo(name, phone, birth);
    }

    public void search() { // 인덱스 번호 반환하는 메서드 따로 떼기
        System.out.println("데이터 검색을 시작합니다.");
        System.out.print("이름 : ");
        name = MenuViewer.sc.nextLine();

        int dataIdx = searchName(name);
        if(dataIdx<0)
            System.out.println("해당하는 데이터가 존재하지 않습니다. \n");
        else{
            infoStorage[dataIdx].showPhoneInfo();
            System.out.println("데이터 검색이 완료되었습니다. \n");
        }
    }

    private int searchName(String name){ // 내부에서만 사용될 메서드 private
        for(int i=0; i<cnt; i++){
            PhoneInfo curInfo = infoStorage[i];
            // compareTo() 객체의 필드값을 비교할 때 사용하는 메서드
            // 비교대상인 값.compareTo(비교할 값)이 일치하면 0을 리턴
            // 두 개의 값이 일치하지 않을시 0외의 값인 1, -1을 리턴
            if(name.compareTo(curInfo.getName())==0)
                return i;
        }
        return -1;
    }

    public void delete() {
        System.out.println("데이터 삭제를 시작합니다.");
        System.out.print("이름 : ");
        name = MenuViewer.sc.nextLine();

        int dataIdx = searchName(name); // 그 사용자의 인덱스를 불러온다
        if(dataIdx<0)
            System.out.println("해당하는 데이터가 존재하지 않습니다. \n");
        else {
            for(int i=dataIdx; i<cnt-1; i++)
                infoStorage[i]=infoStorage[i+1];
            infoStorage[cnt-1] = null;
            cnt--;
            System.out.println("데이터 삭제가 완료되었습니다.");
        }
    }
}

class MenuViewer {
    public static Scanner sc = new Scanner(System.in);

    public static void intro() { // 메뉴 뷰어는 객체 생성 않고 사용할 수 있게 static으로 선언할 수 있음
        System.out.println();
        System.out.println("선택하세요");
        System.out.println("1. 데이터 입력");
        System.out.println("2. 데이터 검색");
        System.out.println("3. 데이터 삭제");
        System.out.println("4. 프로그램 종료");
        System.out.print("선택 : ");
    }
}


public class PhoneBookVer03_answer {
    public static void main(String[] args) { // 실행클래스에서 메서드 만들면 재사용이 불가능
        PhoneBookManager2 pbm = new PhoneBookManager2();
        int menu;

        while(true) {
            MenuViewer.intro();
            menu = MenuViewer.sc.nextInt();
            MenuViewer.sc.nextLine();

            switch(menu) {
                case 1 :
                    pbm.input();
                    break;
                case 2 :
                    pbm.search();
                    break;
                case 3 :
                    pbm.delete();
                    break;
                case 4 :
                    System.out.println("프로그램을 종료합니다.");
                    return;
                default :
                    System.out.println("잘못 입력 하셨습니다.");
                    return;
            }
        }
    }
}
