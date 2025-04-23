from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
import time
import os
from urllib.parse import urlparse

domain = "http://localhost:1990"

def take_screenshot(driver, url, output_folder, path):
    driver.get(url)
    
    time.sleep(1)
    
    path = path.lstrip('/')
    
    folder_path = os.path.join(output_folder, path)
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
    
    screenshot_path = os.path.join(folder_path, "thumbnail.png")
    driver.save_screenshot(screenshot_path)
    print(f"Screenshot saved to: {screenshot_path}")

def main():
    output_folder = "./assets/thumbnails"
    paths = [
        "/",
        "/blog/",
        "/blog/rewriting-openpngstudio-1/",
        "/blog/developing-portable-zig/",
        "/technologies/",
        "/socials/",
        "/gallery/",
    ]

    firefox_options = Options()
    firefox_options.add_argument("--headless")
    firefox_options.add_argument("--width=1920")
    firefox_options.add_argument("--height=1080")
    firefox_options.binary_location = "/bin/firefox-bin"
    
    driver = webdriver.Firefox(options=firefox_options)
    
    try:
        for path in paths:
            url = f"{domain}{path}"
            take_screenshot(driver, url, output_folder, path)
    
    except Exception as e:
        print(f"An error occurred: {e}")
    
    finally:
        driver.quit()

if __name__ == "__main__":
    main()
