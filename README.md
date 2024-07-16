# WordPress Installation Script

This repository contains a Bash script to automate the installation of a WordPress site with a LAMP stack (Linux, Apache, MySQL, PHP) on a Ubuntu-based system. 

## Usage

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/CyberMachan97/Wordpress.git
    cd Wordpress
    ```

2. Update the MySQL root password and the WordPress user password at the top of the `install_wordpress.sh` script:

    ```bash
    # Set passwords
    mysql_root_password="<your_mysql_root_password>"
    wordpress_user_password="<your_wordpress_user_password>"
    ```

3. Save the script and make it executable:

    ```bash
    chmod +x install_wordpress.sh
    ```

4. Run the script with superuser privileges:

    ```bash
    sudo ./install_wordpress.sh
    ```

5. Access your WordPress site by navigating to your server's domain name or IP address in a web browser.

## Important Notes

- Ensure that you replace `<your_mysql_root_password>` and `<your_wordpress_user_password>` with strong, secure passwords.
- This script is intended for use on a fresh Ubuntu installation and assumes no prior setup of Apache, MySQL, or PHP.
- The script includes a command to remove the default Apache `index.html` file to ensure the WordPress index page is served correctly.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

