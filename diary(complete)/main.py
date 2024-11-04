# İçe Aktarma
from flask import Flask, render_template, request, redirect
# Veritabanı kütüphanesini içe aktarma
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
# SQLite'a bağlanma
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///diary.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
# Veritabanı oluşturma
db = SQLAlchemy(app)
# Veritabanı tablosu oluşturma

# Görev #1. Veritabanı tablosu oluşturma
class Card(db.Model):
    # Alanları oluşturma
    # id
    id = db.Column(db.Integer, primary_key=True)
    # Başlık
    title = db.Column(db.String(100), nullable=False)
    # Açıklama
    subtitle = db.Column(db.String(300), nullable=False)
    # Metin
    text = db.Column(db.Text, nullable=False)

    # Nesneyi ve id'sini çıktı olarak verme
    def __repr__(self):
        return f'<Card {self.id}>'

# İçerikle sayfayı çalıştırma
@app.route('/') # app.py dosyasını gir
def index():
    # Veritabanı nesnelerini görüntüleme
    # Görev #2. Veritabanındaki nesneleri index.html'de görüntüleme
    cards = Card.query.order_by(Card.id).all()

    return render_template('index.html', cards=cards) # index.html dosyamız atacağım hazır kodda var araştırmalısın

# Kart ile sayfayı çalıştırma
@app.route('/card/<int:id>')
def card(id):
    # Görev #2. Kartı id'sine göre doğru şekilde görüntüleme
    card = Card.query.get(id)

    return render_template('card.html', card=card)

# Sayfayı çalıştırma ve kart oluşturma
@app.route('/create')
def create():
    return render_template('create_card.html')

# Kart formu
@app.route('/form_create', methods=['GET', 'POST'])
def form_create():
    if request.method == 'POST':
        title = request.form['title']
        subtitle = request.form['subtitle']
        text = request.form['text']

        # Veritabanına gönderilecek nesneyi oluşturma

        # Görev #2. Veritabanında veri saklama yöntemi oluşturma
        card = Card(title=title, subtitle=subtitle, text=text)

        db.session.add(card)
        db.session.commit()
        return redirect('/')
    else:
        return render_template('create_card.html')

if __name__ == "__main__":
    app.run(debug=True)
