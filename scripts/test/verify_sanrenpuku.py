# Verification script for sanrenpuku format

# Simulating top 6 horses: 6(1st), 9(2nd), 10(3rd), 7(4th), 11(5th), 2(6th)
class Horse:
    def __init__(self, rank, umaban):
        self.rank = rank
        self.umaban = umaban

import pandas as pd

# Test data
horses_data = [
    {'umaban': 6, 'rank': 1},
    {'umaban': 9, 'rank': 2},
    {'umaban': 10, 'rank': 3},
    {'umaban': 7, 'rank': 4},
    {'umaban': 11, 'rank': 5},
    {'umaban': 2, 'rank': 6},
]

top_horses = pd.DataFrame(horses_data)

# Extract horse numbers
uma1 = int(top_horses.iloc[0]['umaban'])  # 6
uma2 = int(top_horses.iloc[1]['umaban'])  # 9
uma3 = int(top_horses.iloc[2]['umaban'])  # 10
uma4 = int(top_horses.iloc[3]['umaban'])  # 7

# Format according to new spec
jiku = f"{uma1}.{uma2}"
aite1 = f"{uma2}.{uma3}.{uma4}"
aite2 = '.'.join([str(int(top_horses.iloc[i]['umaban'])) for i in range(1, 6)])

print("=" * 60)
print("三連複フォーマット検証")
print("=" * 60)
print(f"\n上位6頭: {', '.join([str(h['umaban']) for _, h in top_horses.iterrows()])}")
print(f"\n軸 (1位.2位):        {jiku}")
print(f"相手1 (2.3.4位):     {aite1}")
print(f"相手2 (2~6位):      {aite2}")
print(f"\n✅ 最終出力:")
print(f"三連複：{jiku} - {aite1} - {aite2}")
print("\n" + "=" * 60)
print("期待される出力: 三連複：6.9 - 9.10.7 - 9.10.7.11.2")
print("=" * 60)
