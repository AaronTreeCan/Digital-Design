# Slot Machine Game on FPGA

![Slot Machine Display Example](https://via.placeholder.com/800x400.png?text=Slot+Machine+Display)

This project implements a **slot machine game** on an Altera FPGA using **SystemVerilog**, showcasing core digital design principles like **clock dividers**, **shift registers**, and **finite state machines (FSMs)**. The system features interactive gameplay, responsive state transitions, and a visual output using a **seven-segment display**.

## Project Overview

### Objective
To design and verify a functional slot machine game capable of displaying random numbers, detecting wins, and providing visual/auditory feedback based on the game's outcome.

### Key Features
- **Clock Divider**: Generates slower clock signals from the FPGA's 50 MHz clock for synchronized operations.
- **Finite State Machine (FSM)**: Controls the game states (`SET`, `RUN`, `STOP`, `WIN`) and transitions.
- **Shift Registers**: Implements pseudo-random number generation for slot results.
- **Seven-Segment Display**: Displays slot outcomes in real time.
- **Buzzer Feedback**: Signals win conditions with an audible tone.

![FSM Diagram](https://via.placeholder.com/800x400.png?text=FSM+Diagram)

## Technical Highlights

### Core Modules
1. **Clock Divider**: Produces reduced clock speeds for various game components.
2. **Slot Module**: Generates random numbers using linear feedback shift registers (LFSRs).
3. **FSM Controller**: Manages the game flow based on player inputs and game conditions.
4. **Seven-Segment Display Driver**: Converts binary outputs into human-readable numbers.

### Game States
1. **SET**: Initializes slot values and resets the system.
2. **RUN**: Spins the slots at different speeds when the start/stop button is pressed.
3. **STOP**: Stops the slot reels and blinks the results.
4. **WIN**: Activates the buzzer and changes the blink rate if all slots match.

### Hardware Components
- **Altera FPGA**: Implements the game's logic.
- **Seven-Segment Display**: Displays slot numbers.
- **Buzzer**: Provides audible win feedback.
- **Push Buttons**: Controls start/stop and reset functionality.

## Results
- **Interactive Gameplay**: Real-time slot results displayed on the FPGA.
- **Reliable State Transitions**: FSM ensures seamless state changes.
- **High Responsiveness**: Low-latency input processing and visual updates.

![Slot Machine Demo](https://via.placeholder.com/800x400.png?text=Slot+Machine+Demo)

## How to Use

### Prerequisites
- Quartus Prime Design Software
- Altera FPGA Board (e.g., DE2-115)
- Breadboard and buzzer for audio feedback

### Setup and Execution
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/fpga-slot-machine.git
   cd fpga-slot-machine


<h1>Slot Machine</h1>


<h2>Description</h2>
This project implements a fully functional slot machine game on an Altera FPGA using SystemVerilog. It leverages key digital design principles such as clock dividers, shift registers, and finite state machines (FSM) to simulate the behavior of a real-world slot machine.
<br />


<h2>Languages and Tools Used</h2>

- <b>SystemVerilog</b>
- <b>Quartus</b> 
- <b>QuestaSim</b>
- <b>FPGA</b>

<h2>Features ✨</h2>
<ul>
    <li><b>Random Number Generation</b>:
        <ul>
            <li>Utilizes clock dividers and shift registers to generate pseudo-random numbers, mimicking the spinning reels of a traditional slot machine.</li>
        </ul>
    </li>
    <li><b>Finite State Machine</b>:
        <ul>
            <li>Tracks four distinct states:</li>
            <li><b>Set</b>: Resets the machine to a default value.</li>
            <li><b>Run</b>: Spins the reels continuously.</li>
            <li><b>Stop</b>: Halts the reels and highlights the stopped number.</li>
            <li><b>Win</b>: Activates a special mode if all numbers match, including fast blinking lights and a buzzer.</li>
        </ul>
    </li>
    <li><b>Interactive Controls</b>:
        <ul>
            <li>A button on the FPGA toggles between states:</li>
            <li>Reset to default.</li>
            <li>Start spinning the reels.</li>
            <li>Stop and hold on a number.</li>
            <li>Trigger a win sequence when conditions are met.</li>
        </ul>
    </li>
    <li><b>Visual and Audio Effects</b>:
        <ul>
            <li>LEDs blink to indicate the stopped number.</li>
            <li>Winning sequences include fast blinking LEDs and a buzzer sound for enhanced feedback.</li>
        </ul>
    </li>
</ul>
