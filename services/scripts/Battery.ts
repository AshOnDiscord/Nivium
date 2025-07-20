import { $ } from "bun";

const batteryDir = "/sys/class/power_supply/BAT1/";
const chargerDir = "/sys/class/power_supply/ACAD/";
const battery = {
  charge: 0,
  capacity: 0,
  icon: "battery4",
  lowThreshold: Infinity,
  low: false,
  // based on if the charger is connected, not if the battery is actuall charging
  // because otherwise its confusing when the charger is connected but ui shows not charging
  charging: false,
};

const updateOutput = () => {
  console.log(JSON.stringify(battery));
};

const updateLow = () => {
  battery.low = battery.charge < battery.lowThreshold;
};

const updateCharge = async () => {
  battery.charge = +(await $`cat ${batteryDir}charge_now`.quiet().text());
  updateLow();
};

const updateCapacity = async () => {
  battery.capacity = +(await $`cat ${batteryDir}charge_full`.quiet().text());
};

const updateLowThreshold = async () => {
  battery.lowThreshold = +(await $`cat ${batteryDir}alarm`.quiet().text());
  updateLow();
};

const updateCharging = async () => {
  battery.charging = +(await $`cat ${chargerDir}online`.quiet().text()) == 1;
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
  cmd: ["udevadm", "monitor", "--kernel", "--subsystem-match=power_supply"],
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
    } else if (line.includes("BAT1")) {
      updateBattery();
    }
  }
}
