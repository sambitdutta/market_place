RSpec.describe MarketPlace::Store do
  describe '.configure' do
    it 'is expected to yield control' do
      expect { |c| described_class.configure(&c) }.to yield_control
    end
  end

  describe '#add' do
    let(:instance) { described_class.new }

    before { allow(described_class).to receive(:store_config).and_return(instance) }

    context 'add product' do
      it 'should add product' do
        expect { instance.add :product, double(MarketPlace::Product) }.to change(described_class.products, :size).by(1)
      end
    end

    context 'add promotion' do
      it 'should add promotion' do
        expect { instance.add :promotion, 'test' }.to change(described_class.promotions, :size).by(1)
      end
    end

    context 'error' do
      it 'should raise error' do
        expect { instance.add :anything, 123 }.to raise_error(RuntimeError)
      end
    end
  end

  describe '.promotions' do
    subject { described_class.promotions }

    it 'should contain 2 promotions by default' do
      expect(subject.size).to eq(2)
    end
  end

  describe '.products' do
    subject { described_class.products }

    it 'should contain 3 products by default' do
      expect(subject.size).to eq(3)
    end
  end
end
