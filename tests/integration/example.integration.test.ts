import { describe, it, expect } from 'vitest';

describe('sanity integration tests', () => {
  it('simple arithmetic', () => {
    expect(1 + 1).toBe(2);
  });
});
