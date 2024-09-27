window.onload = function() {
    const repairButton = document.getElementById('repair-vehicle');
    const messageDiv   = document.getElementById('message');

    repairButton.onclick = function() {
        // Send a message to the server to handle vehicle repair
        fetch(`https://${GetParentResourceName()}/repairVehicle`, {
            method: 'POST',
        })
        .then(response => response.json())
        .then(data => {
            messageDiv.innerText = data.message;
        });
    };
};

// Function to close the NUI
function closeUI() {
    document.getElementById('mechanic-job-ui').style.display = 'none';
    SendNUIMessage({ action: 'close' });
}
