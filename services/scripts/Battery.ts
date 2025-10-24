import { $ } from "bun";

const batteryDir = "/sys/class/power_supply/BAT1/";
const chargerDir = "/sys/class/power_supply/ACAD/";

const chargeFile = Bun.file(`${batteryDir}charge_now`);
const capacityFile = Bun.file(`${batteryDir}charge_full`);
const lowThresholdFile = Bun.file(`${batteryDir}alarm`);
const chargingFile = Bun.file(`${chargerDir}online`);

const battery = {
  charge: 0,
  capacity: 1,
  icon: "battery4",
  lowThreshold: Infinity,
  low: false,
  // based on if the charger is connected, not if the battery is actuall charging
  // because otherwise its confusing when the charger is connected but ui shows not charging
  charging: false,
};

const updateIcon = () => {
  const charge = battery.charge / battery.capacity;

  if (battery.charging) {
    battery.icon = "battery_charging";
  } else if (charge > 0.8) {
    battery.icon = "battery4";
  } else if (charge > 0.6) {
    battery.icon = "battery3";
  } else if (charge > 0.4) {
    battery.icon = "battery2";
  } else if (charge > 0.2) {
    battery.icon = "battery1";
  } else if (!battery.low) {
    battery.icon = "battery0";
  } else {
    battery.icon = "battery_low";
  }
};

const updateOutput = () => {
  updateIcon();
  console.log(JSON.stringify(battery));
};

const updateLow = () => {
  battery.low = battery.charge < battery.lowThreshold;
};

const updateCharge = async () => {
  battery.charge = +(await chargeFile.text());
  updateLow();
};

const updateCapacity = async () => {
  battery.capacity = +(await capacityFile.text());
};

const updateLowThreshold = async () => {
  battery.lowThreshold = +(await lowThresholdFile.text());
  updateLow();
};

const updateCharging = async () => {
  battery.charging = +(await chargingFile.text()) == 1;
};

await Promise.all([
  updateCharge(),
  updateCapacity(),
  updateLowThreshold(),
  updateCharging(),
]);
updateOutput();

const updateBattery = async () => {
  await Promise.all([updateCharge(), updateCapacity(), updateLowThreshold()]);
  updateOutput();
};

const updateCharger = async () => {
  await updateCharging();
  updateOutput();
};

const decoder = new TextDecoder();
const proc = Bun.spawn({
  cmd: ["upower", "-m"],
  stdout: "pipe",
  stderr: "pipe",
});

let buffer = "";

for await (const chunk of proc.stdout) {
  buffer += decoder.decode(chunk);

  const lines = buffer.split("\n");
  buffer = lines.pop() ?? "";

  for (const line of lines) {
    if (line.includes("ACAD")) {
      updateCharger();
    } else if (line.includes("BAT0") || line.includes("BAT1")) {
      updateBattery();
    }
  }
}
