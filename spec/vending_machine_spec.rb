# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe VendingMachine do

  context "特になにもしない状態" do
    subject { VendingMachine.new }
    describe "最初の合計金額は 0円" do
      its(:total) { should == 0 }
    end
  end

  context "1000 yen" do
    before do
      @vm = VendingMachine.new
      @vm.put_in 1000
    end
    subject { @vm }
    its(:total) { should == 1000 }
  end

  context "特になにもしない状態" do
    it "最初の合計金額は 0円" do
      subject.total.should == 0
    end
    it "お金として1000円を投入できる" do
      subject.put_in 1000
      subject.total.should == 1000
    end
    it "入力は複数回できる" do
      subject.put_in 500
      subject.put_in 1000
      subject.total.should == 1500
    end

    context "お金として1円玉を投入されるとき" do
      before do
        subject.put_in 1
      end
      it "合計金額は 0円のまま" do
        subject.total.should == 0
      end
      it "釣り銭として 1円が戻ってくる" do
        subject.change.should =~ [1]
      end
    end
    it "1円を3回投入したら、1円が3回返ってくる" do
      3.times { subject.put_in 1 }
      subject.change.should =~ [1, 1, 1]
    end
    it "想定された硬貨を投入したら釣り銭は 0円" do
      subject.put_in 50
      subject.change.should be_empty
    end
    context "払い戻しボタンを押すと" do
      before do
        subject.put_in 100
        subject.put_in 500
        subject.back
      end
      it "投入した硬貨がすべて戻ってくる" do
        subject.change.should =~ [100, 500]
      end
      it "合計は 0円に戻る" do
        subject.total.should == 0
      end
    end
    it "払い戻した後に、硬貨を投入すると追加分だけがカウントされる" do
      subject.put_in 100
      subject.back
      subject.put_in 50
      subject.total.should == 50
      subject.change.should =~ [100]
    end
    it "10円を5回投入すると、払い戻すと50円を1枚返す"

    context "ジュースの管理をする" do

      before do
        @orange = Juice.new("orange", 100)
      end
      it "ジュースを1種類格納できる" do
        subject.store @orange
        subject.products.should include (@orange)
      end
      it "初期状態でコーラが入っている" do
        subject.products.should have(5).items
        subject.products.first.name.should == "コーラ"
      end
      it "在庫を表示する" do
        subject.store @orange
        subject.stock.should =~ [["コーラ", 5], ["orange", 1]]
      end
    end

    context "100円いれる" do
      before do
        @orange = Juice.new("orange", 100)
        subject.put_in 100
        subject.store @orange
      end
      it "コーラは買えない" do
        subject.purchasable("コーラ").should be_false
      end
      it "オレンジは買える" do
        subject.purchasable("orange").should be_true
      end
    end


  end
end
