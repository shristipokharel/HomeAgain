// Initialize Material Design Components
document.addEventListener('DOMContentLoaded', function() {
    // Initialize all MDC components
    mdc.autoInit();

    // Initialize snackbars
    const snackbars = document.querySelectorAll('.mdc-snackbar');
    snackbars.forEach(snackbar => {
        new mdc.snackbar.MDCSnackbar(snackbar);
    });

    // Initialize text fields
    const textFields = document.querySelectorAll('.mdc-text-field');
    textFields.forEach(textField => {
        new mdc.textField.MDCTextField(textField);
    });

    // Initialize buttons
    const buttons = document.querySelectorAll('.mdc-button');
    buttons.forEach(button => {
        new mdc.ripple.MDCRipple(button);
    });

    // Form validation
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });

    // Image preview for file inputs
    const fileInputs = document.querySelectorAll('input[type="file"]');
    fileInputs.forEach(input => {
        input.addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                const preview = document.querySelector(`#${input.id}-preview`);
                if (preview) {
                    reader.onload = function(e) {
                        preview.src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            }
        });
    });

    // Show/hide password functionality
    const passwordToggles = document.querySelectorAll('.password-toggle');
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const passwordInput = document.querySelector(this.dataset.target);
            if (passwordInput) {
                const type = passwordInput.type === 'password' ? 'text' : 'password';
                passwordInput.type = type;
                this.textContent = type === 'password' ? 'visibility' : 'visibility_off';
            }
        });
    });

    // Handle AJAX form submissions
    const ajaxForms = document.querySelectorAll('form[data-ajax="true"]');
    ajaxForms.forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const formData = new FormData(form);
            
            fetch(form.action, {
                method: form.method,
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showSnackbar(data.message, 'success');
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    }
                } else {
                    showSnackbar(data.message, 'error');
                }
            })
            .catch(error => {
                showSnackbar('An error occurred. Please try again.', 'error');
                console.error('Error:', error);
            });
        });
    });
});

// Utility function to show snackbar messages
function showSnackbar(message, type = 'info') {
    const snackbar = document.createElement('div');
    snackbar.className = `mdc-snackbar mdc-snackbar--${type}`;
    snackbar.innerHTML = `
        <div class="mdc-snackbar__surface">
            <div class="mdc-snackbar__label">${message}</div>
        </div>
    `;
    document.body.appendChild(snackbar);
    const mdcSnackbar = new mdc.snackbar.MDCSnackbar(snackbar);
    mdcSnackbar.open();
    setTimeout(() => {
        snackbar.remove();
    }, 3000);
}

// Handle dynamic content loading
function loadContent(url, targetId) {
    const target = document.getElementById(targetId);
    if (target) {
        fetch(url)
            .then(response => response.text())
            .then(html => {
                target.innerHTML = html;
                mdc.autoInit();
            })
            .catch(error => {
                console.error('Error loading content:', error);
                showSnackbar('Failed to load content', 'error');
            });
    }
} 