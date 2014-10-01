require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      items[0].name.should == "foo"
    end

    it "never has a negative quality" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    context "sellIn >= 0" do

      it "quality reduces by one" do
        items = [Item.new("foo", 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(9)
      end

      it "sellIn should reduce by 1" do
        items = [Item.new("foo", 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(9)
      end
    end

    context "sellIn < 0" do

      it "quality reduces by 2" do
        items = [Item.new("foo", -1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(8)
      end

    end

    context "Aged Brie" do  
      it "increases quality by 1" do 
        items = [Item.new("Aged Brie", 1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(11)
      end 

      it "will not increase passed 50 quality" do
        items = [Item.new("Aged Brie", -1, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(50)
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it 'never changes its quality' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(10)
      end
    end

    context "Backstage Pass" do
      context "more than 10 days" do
        it "increases quality by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(11)
        end
      end
      context "between 5 and 10 days" do
        it "increases quality by 2" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(12)
        end
      end
      context "between 5 and 0 days" do
        it "increases quality by 3" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(13)
        end
      end
      context "passed sellIn" do
        it "has 0 quality" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end
      end

    end
  end


end
