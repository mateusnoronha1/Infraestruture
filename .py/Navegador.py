from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget
from PyQt5.QtWebEngineWidgets import QWebEngineView
from PyQt5.QtCore import QUrl
import sys

class SimpleBrowser(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Navegador MV")

        # Cria o widget do navegador
        self.browser = QWebEngineView()

        # Configurações básicas (tentativa de habilitar plugins)
        self.browser.page().settings().setAttribute(self.browser.page().settings().PluginsEnabled, True)

        # Define a URL inicial
        self.browser.setUrl(QUrl("https://webbrowsertools.com/test-flash-player/"))

        # Layout
        layout = QVBoxLayout()
        layout.addWidget(self.browser)

        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = SimpleBrowser()
    window.show()
    sys.exit(app.exec_())
