import { $ } from "bun";
import { watch } from "fs";

const screenName = (await $`brightnessctl -m`.quiet().text()).split(",")[0];
const screenDir = `/sys/class/backlight/${screenName}/`;

const brightnessFile = Bun.file(`${screenDir}brightness`);
const brightnessMaxFile = Bun.file(`${screenDir}max_brightness`);

const getBrightnessRaw = async () => {
  return +(await brightnessFile.text());
};
const getBrightnessMax = async () => {
  return +(await brightnessMaxFile.text());
};

let brightnessRaw = await getBrightnessRaw();
let brightnessMax = await getBrightnessMax();

console.log(brightnessRaw / brightnessMax);

watch(`${screenDir}brightness`, async () => {
  brightnessRaw = await getBrightnessRaw();
  console.log(brightnessRaw / brightnessMax);
});

watch(`${screenDir}max_brightness`, async () => {
  brightnessMax = await getBrightnessMax();
  console.log(brightnessRaw / brightnessMax);
});
