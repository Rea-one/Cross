
export function TransInside(value: object): string {
  return JSON.stringify(value)
}

export function TransOutside(value: string | number | boolean | Uint8Array): object | null {
  if (typeof(value) == "string") {
    return JSON.parse(value)
  }
  return null
}